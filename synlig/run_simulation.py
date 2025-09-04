from pathlib import Path
import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile
import concurrent.futures

def run_make(recipe, dry_run=False):
    """Run the make command to build the specified recipe."""
    print(f"Building: make {recipe}")
    
    if dry_run:
        return
    
    result = subprocess.run(["make", recipe], capture_output=True, text=True)
    
    if result.returncode != 0:
        error_msg = f"Error during make {recipe} (exit code {result.returncode})"
        if result.stderr:
            error_msg += f":\n{result.stderr}"
        raise RuntimeError(error_msg)

def run_simulation(bootrom, rom, secs, output_name, capture_output=False, dry_run=False):
    """Run the simulation using vvp with the specified parameters."""
    # Ensure ROM and bootrom exist
    if not dry_run:
        if not Path(rom).exists():
            raise FileNotFoundError(f"ROM file not found: {rom}")
        
        if not Path(bootrom).exists():
            raise FileNotFoundError(f"Bootrom file not found: {bootrom}")
        
        # Ensure output directory exists
        output_dir = Path(output_name).parent
        output_dir.mkdir(parents=True, exist_ok=True)
    
    vvp_command = [
        "vvp", "-N", "run.vvp",
        "-fst-speed-space",
        f"+DUMPFILE={output_name}.fst",
        f"+CH_FILE={output_name}_ch%0d.snd",
        f"+SND_FILE={output_name}.snd",
        f"+VID_FILE={output_name}.vid",
        f"+BOOTROM={bootrom}",
        f"+ROM={rom}",
        f"+SECS={secs}"
    ]

    print(f"Running command: {' '.join(vvp_command)}")
    
    if dry_run:
        return
    
    result = subprocess.run(vvp_command, capture_output=capture_output, text=True)
    
    if result.returncode != 0:
        error_msg = f"Error during simulation (exit code {result.returncode})"
        if result.stderr:
            error_msg += f": {result.stderr}"
        raise RuntimeError(error_msg)

def run_verilator(bootrom, rom, secs, output_name, capture_output=False, dry_run=False):
    """Run the simulation using Verilator with the specified parameters."""
    # Ensure ROM and bootrom exist
    if not dry_run:
        if not Path(rom).exists():
            raise FileNotFoundError(f"ROM file not found: {rom}")
        
        if not Path(bootrom).exists():
            raise FileNotFoundError(f"Bootrom file not found: {bootrom}")
        
        # Ensure output directory exists
        output_dir = Path(output_name).parent
        output_dir.mkdir(parents=True, exist_ok=True)
    
    vvp_command = [
        "verilator_build/Vdmg_cpu_b_gameboy",
        "+verilator+rand+reset+1",
        f"+DUMPFILE={output_name}.fst",
        f"+CH_FILE={output_name}_ch%0d.snd",
        f"+SND_FILE={output_name}.snd",
        f"+VID_FILE={output_name}.vid",
        f"+BOOTROM={bootrom}",
        f"+ROM={rom}",
        f"+SECS={secs}"
    ]

    print(f"Running command: {' '.join(vvp_command)}")
    
    if dry_run:
        return
    
    result = subprocess.run(vvp_command, capture_output=capture_output, text=True)
    
    if result.returncode != 0:
        error_msg = f"Error during Verilator simulation (exit code {result.returncode})"
        if result.stderr:
            error_msg += f": {result.stderr}"
        raise RuntimeError(error_msg)

def run_mkvid(filename, raw: bool = False, dry_run=False):
    """Generate video from simulation output files."""
    script_dir = Path(__file__).resolve().parent
    cur_dir = Path.cwd()
    
    # Check if video file exists
    vid_file_path = cur_dir / f"{filename}.vid"
    if not dry_run and not vid_file_path.exists():
        raise FileNotFoundError(f"Video file not found: {vid_file_path}")

    snd_file_path = Path(filename).with_suffix(".snd").resolve()
    last_frame_path = Path(filename).with_suffix(".png").resolve()
    video_path = Path(filename).with_suffix(".mkv").resolve()
    output_dir = Path(filename).parent.resolve()

    
    if dry_run:
        # Print commands that would be run
        mkimgs_path = script_dir / ".." / "mkvid" / "mkimgs"
        mkimgs_cmd = f"{mkimgs_path} {' --raw' if raw else ''} < {vid_file_path}"
        print(f"Would run: {mkimgs_cmd}")
        
        # Print image conversion commands
        imgsize = "640x576" if not raw else "160x144"
        print(f"Would convert frames to PNG with size {imgsize}")
        
        # Print ffmpeg commands
        print(f"Would create video.mp4 with ffmpeg")
        print(f"Would create {video_path} with ffmpeg")
        return
    
    # Create temporary directory with automatic cleanup
    tmpdir = tempfile.mkdtemp()
    original_dir = os.getcwd()

    try:
        os.chdir(tmpdir)

        print(f"Generating video for {filename}")
        
        # Run mkimgs
        with open(vid_file_path, "rb") as vid_file:
            mkimgs_path = script_dir / ".." / "mkvid" / "mkimgs"
            if not mkimgs_path.exists():
                raise FileNotFoundError(f"mkimgs tool not found at {mkimgs_path}")
                
            args = [str(mkimgs_path)] + (["--raw"] if raw else [])
            print(f"Running: {' '.join(args)}")
            result = subprocess.run(args, stdin=vid_file, capture_output=True)
            
            if result.returncode != 0:
                error_msg = f"Error during mkimgs (exit code {result.returncode})"
                if result.stderr:
                    error_msg += f": {result.stderr.decode('utf-8', errors='ignore')}"
                raise RuntimeError(error_msg)

        # Image size
        imgsize = "640x576" if not raw else "160x144"

        # Convert .rgb to .png
        i = 0
        while True:
            rgb_file = Path(tmpdir) / f"img{i:06d}.rgb"
            if not rgb_file.exists():
                break
            png_file = Path(tmpdir) / f"img{i:06d}.png"
            
            result = subprocess.run(
                [
                    "magick",
                    "-size", imgsize,
                    "-depth", "8",
                    f"RGB:{rgb_file}",
                    str(png_file),
                ],
                capture_output=True
            )
            
            if result.returncode != 0:
                print(f"Warning: Error converting frame {i} to PNG, continuing...")
            
            i += 1

        num_frames = i
        if num_frames == 0:
            print(f"Warning: No frames generated for {filename}")
            return

        # Create output directory if it doesn't exist
        output_dir.mkdir(parents=True, exist_ok=True)

        # Save the final frame
        try:
            shutil.copy(
                Path(tmpdir) / f"img{num_frames - 1:06d}.png",
                last_frame_path
            )
        except FileNotFoundError:
            print(f"Warning: Could not save final frame for {filename}")

        # Create video.mp4
        result = subprocess.run(
            [
                "ffmpeg", "-r", "64", "-f", "image2", "-s", imgsize,
                "-start_number", "0", "-i", "img%06d.png",
                "-vframes", str(num_frames),
                "-vcodec", "libx264", "-crf", "0", "-pix_fmt", "yuv420p",
                "video.mp4",
            ],
            capture_output=True
        )
        
        if result.returncode != 0:
            print(f"Warning: Error creating video.mp4, MKV may not be generated")
        
        # Check if sound file exists
        if not snd_file_path.exists():
            print(f"Warning: Sound file not found: {snd_file_path}")

            if Path("video.mp4").exists():
                shutil.copy(
                    "video.mp4",
                    video_path
                )
        else:
            # Add audio, produce final MKV
            result = subprocess.run(
                [
                    "ffmpeg", "-y", "-i", "video.mp4",
                    "-i", str(snd_file_path),
                    "-c:v", "copy", "-c:a", "mp3",
                    str(video_path),
                ],
                capture_output=True
            )
            
            if result.returncode != 0:
                print(f"Warning: Error creating MKV file")

    except Exception as e:
        print(f"Error during video generation: {e}")
        raise
    finally:
        os.chdir(original_dir)
        shutil.rmtree(tmpdir)

def run_single_test(test_entry, roms_base_path, output_base_path, bootrom_path, verilate, dry_run=False):
    """Run a single test from the test database."""
    rom_path = test_entry.get("rom_path")
    if not rom_path:
        print(f"Warning: Test entry missing rom_path, skipping: {test_entry}")
        return False
    
    # Calculate the timeout in seconds
    timeout_cycles = test_entry.get("timeout_cycles", 25000000) - 23_440_324  # Default to 25M cycles
    timeout_secs = timeout_cycles / (2**22)  # Convert cycles to seconds
    timeout_secs += 0.25  # Add 250ms for safety

    # if timeout_secs > 0.7:
    #     return False
    
    try:
        # Create output directory structure mirroring the ROM path
        rel_path = Path(rom_path)
        output_dir = output_base_path / rel_path.parent
        if not dry_run:
            output_dir.mkdir(parents=True, exist_ok=True)
        
        # Define output name based on ROM filename without extension
        output_name = str(output_dir / rel_path.stem)
        
        # Full path to the ROM
        full_rom_path = roms_base_path / rom_path
        
        if not dry_run and not full_rom_path.exists():
            print(f"Warning: ROM file not found: {full_rom_path}")
            return False
        
        print(f"Running test: {rom_path}")
        print(f"  - Timeout: {timeout_secs:.2f} seconds ({timeout_cycles} cycles)")
        print(f"  - Output: {output_name}")
        print(f"  - {'DRY RUN - commands will not be executed' if dry_run else 'EXECUTING'}")
        
        # Run the simulation
        # if verilate:
        #     run_verilator(bootrom_path, str(full_rom_path), timeout_secs, output_name, capture_output=True, dry_run=dry_run)
        # else:
        #     run_simulation(bootrom_path, str(full_rom_path), timeout_secs, output_name, capture_output=True, dry_run=dry_run)
        
        # Generate video
        run_mkvid(output_name, True, dry_run=dry_run)

        if not dry_run:
            # Check if output image match expected
            generated_image_path = Path(output_name).with_suffix(".png")
            expected_image_path = None

            test_entry.get("success_check")
            for check in test_entry.get("success_check", []):
                if check.get("type") == "screen_output":
                    expected_image_path = Path(check.get("output_path"))
                    break
                if check.get("type") == "screen_comparison":
                    expected_image_path = roms_base_path / Path(check.get("reference_path"))
                    break

            if expected_image_path is None:
                print(f"Warning: No expected image defined for comparison in test entry: {rom_path}")
                return False

            print(f"Comparing {generated_image_path} {expected_image_path}")

            if not expected_image_path.exists():
                print(f"Warning: Expected image not found for comparison: {expected_image_path}")
                return False
            
            if not generated_image_path.exists():
                print(f"Warning: Generated image not found for comparison: {generated_image_path}")
                return False
            
            # Compare images
            result = subprocess.run(
                [
                    "magick", "compare",
                    "-metric", "AE",
                    str(expected_image_path),
                    str(generated_image_path),
                    "null:"
                ],
                capture_output=True,
                text=True
            )
            
            if result.returncode != 0 and result.returncode != 1:
                print(f"Warning: Error during image comparison for {rom_path}")
                return False
            
            # The output is in stderr
            diff_pixels = int(result.stderr.split()[0])
            if diff_pixels > 0:
                print(f"Test failed: {rom_path} - {diff_pixels} pixels differ from expected")
                return False
            else:
                print(f"Test passed: {rom_path}")
        
        return True
    except Exception as e:
        print(f"Error running test {rom_path}: {e}")
        return False

def run_tests_from_database(test_database_path, roms_base_path, output_base_path, bootrom_path, max_workers=None, verilate=False, dry_run=False):
    """Run all tests from the test database in parallel."""
    # Load the test database
    with open(test_database_path, 'r') as f:
        test_database = json.load(f)

    # Sort database by decreasing timeout_cycles
    test_database.sort(key=lambda x: x.get("timeout_cycles", 25000000), reverse=True)

    # DEBUG: only run the last 10 tests
    # test_database = test_database[-10:]
    
    # Create the output directory if it doesn't exist
    if not dry_run:
        output_base_path.mkdir(parents=True, exist_ok=True)
    
    print(f"Starting test run with {len([t for t in test_database if 'rom_path' in t])} tests")
    print(f"Tests will be saved to: {output_base_path}")
    print(f"ROM files will be loaded from: {roms_base_path}")
    print(f"Bootrom: {bootrom_path}")
    print(f"Maximum parallel workers: {max_workers or 'Default (CPU count)'}")
    if dry_run:
        print("DRY RUN MODE: Commands will be printed but not executed")
        
    # Build if needed
    if verilate:
        run_make("verilator_build/Vdmg_cpu_b_gameboy", dry_run=dry_run)
    else:
        run_make("run.vvp", dry_run=dry_run)
    
    # Set up parallel execution
    results = {}
    with concurrent.futures.ProcessPoolExecutor(max_workers=max_workers) as executor:
        future_to_test = {
            executor.submit(
                run_single_test, 
                test_entry, 
                roms_base_path, 
                output_base_path, 
                bootrom_path,
                verilate,
                dry_run
            ): (test_entry.get("rom_path", f"unknown_{i}"), test_entry) 
            for i, test_entry in enumerate(test_database) 
            if "rom_path" in test_entry
        }
        
        completed = 0
        total = len(future_to_test)
        
        for future in concurrent.futures.as_completed(future_to_test):
            test_path, test_entry = future_to_test[future]
            completed += 1
            try:
                success = future.result()
                results[test_path] = success
                print(f"[{completed}/{total}] {'✓' if success else '✗'} {test_path}")
            except Exception as exc:
                print(f"[{completed}/{total}] ✗ Test {test_path} generated an exception: {exc}")
                results[test_path] = False
    
    # Save results to a log file
    log_path = output_base_path / "test_results.log"
    with open(log_path, 'w') as f:
        f.write(f"Test run completed at {Path(__file__).resolve().parent}\n")
        f.write(f"Total tests: {len(results)}\n")
        f.write(f"Successful tests: {sum(1 for success in results.values() if success)}\n\n")
        
        f.write("Test Results:\n")
        for test_path, success in results.items():
            f.write(f"{'✓' if success else '✗'} {test_path}\n")
    
    # Print summary
    total = len(results)
    successful = sum(1 for success in results.values() if success)
    print(f"\nTest run completed: {successful}/{total} tests ran successfully")
    print(f"Results log saved to: {log_path}")

def main():
    parser = argparse.ArgumentParser(description="Run the Gameboy simulation.")
    # Regular mode arguments
    parser.add_argument("rom", help="Path to the ROM file.", nargs='?')
    parser.add_argument("--bootrom", default="../boot/quickboot.bin", help="Path to the bootrom file (default: boot/quickboot.bin).")
    parser.add_argument("--secs", type=float, default=6.0, help="Number of seconds to simulate (default: 6.0).")
    parser.add_argument("--output", help="Base name for the output files (e.g., 'output' for output.fst, output.vid, etc.).")
    parser.add_argument("--only-mkvid", action="store_true", help="Only generate the video from existing output files.")
    parser.add_argument("--verilate", action="store_true", help="Use Verilator for simulation.")
    parser.add_argument("--dry-run", action="store_true", help="Print commands that would be executed without actually running them.")
    
    # Test mode arguments
    parser.add_argument("--run-tests", nargs="?", const="test_database.json", help="Run tests from the specified test database JSON file (default: test_database.json).")
    parser.add_argument("--roms-base-path", default="/home/rodrigodd/repos/gameroy/core/tests/gameboy-test-roms", help="Base path for ROM files.")
    parser.add_argument("--test-output-path", default="test_run", help="Directory where test outputs will be stored.")
    parser.add_argument("--max-workers", type=int, help="Maximum number of parallel test workers. Default is number of CPUs.")

    args = parser.parse_args()

    # Run in test mode if --run-tests flag is specified
    if args.run_tests:
        test_database_path = Path(args.run_tests)
        roms_base_path = Path(args.roms_base_path)
        output_base_path = Path(args.test_output_path)
        
        run_tests_from_database(
            test_database_path,
            roms_base_path,
            output_base_path,
            args.bootrom,
            args.max_workers,
            args.verilate,
            args.dry_run
        )
    else:
        # Regular mode - run a single simulation
        if args.rom is None:
            parser.error("ROM file path is required when not in test mode")
        
        if args.output is None:
            parser.error("--output is required when not in test mode")
            
        if not args.only_mkvid:
            if args.verilate:
                run_make("verilator_build/Vdmg_cpu_b_gameboy", dry_run=args.dry_run)
                run_verilator(args.bootrom, args.rom, args.secs, args.output, dry_run=args.dry_run)
            else:
                run_make("run.vvp", dry_run=args.dry_run)
                run_simulation(args.bootrom, args.rom, args.secs, args.output, dry_run=args.dry_run)
        run_mkvid(args.output, False, dry_run=args.dry_run)

if __name__ == "__main__":
    main()

