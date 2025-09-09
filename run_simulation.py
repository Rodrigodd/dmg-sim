import argparse
import subprocess

def run_make():
    """Run the make command to build dmg_cpu_b_gameboy.vvp."""
    try:
        subprocess.run(["make", "dmg_cpu_b_gameboy.vvp"], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error during make: {e}")
        exit(1)

def run_simulation(bootrom, rom, secs, output_name):
    """Run the simulation using vvp with the specified parameters."""
    vvp_command = [
        "vvp", "-N", "dmg_cpu_b_gameboy.vvp",
        "-fst-speed-space",
        f"+DUMPFILE={output_name}.fst",
        f"+CH_FILE={output_name}_ch%0d.snd",
        f"+SND_FILE={output_name}.snd",
        f"+VID_FILE={output_name}.vid",
        f"+BOOTROM={bootrom}",
        f"+ROM={rom}",
        f"+SECS={secs}"
    ]

    try:
        subprocess.run(vvp_command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error during simulation: {e}")
        exit(1)

def run_mkvid(output_name):
    """Run the mkvid script to generate the video."""
    mkvid_command = ["mkvid/mkvid.sh", output_name]

    try:
        subprocess.run(mkvid_command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error during mkvid: {e}")
        exit(1)

def main():
    parser = argparse.ArgumentParser(description="Run the Gameboy simulation.")
    parser.add_argument("rom", help="Path to the ROM file.")
    parser.add_argument("--bootrom", default="boot/quickboot.bin", help="Path to the bootrom file (default: boot/quickboot.bin).")
    parser.add_argument("--secs", type=float, default=6.0, help="Number of seconds to simulate (default: 6.0).")
    parser.add_argument("--output", required=True, help="Base name for the output files (e.g., 'output' for output.fst, output.vid, etc.).")

    args = parser.parse_args()

    run_make()
    run_simulation(args.bootrom, args.rom, args.secs, args.output)
    run_mkvid(args.output)

if __name__ == "__main__":
    main()

