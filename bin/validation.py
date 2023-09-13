#!/Users/ryanames/opt/miniconda3/envs/python/bin/python3
import argparse
import os
import pandas as pd

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('-m', '--metadata', type=str, required=True, help='The metadata file.')
    parser.add_argument('-d', '--directory', type=str, required=True, help='Directory containing the sequencing files')
    args = parser.parse_args()

    ## Checking mapping file ##
    print("Checking metadata file: {}".format(args.metadata))
    if os.path.isfile(args.metadata):
        print("Found metadata file")
        (passed, samples, errors) = validateMetadata(args.metadata)
        if passed:
            print("Successfully validated metadata file")
            print("Checking for sequencing files in {0}".format(args.directory))
            (passed, errors) = validateSamples(args.directory, samples)
            if passed:
                print("Successfully validated all samples")
            else:
                writeErrors(errors)
                exit(0)
        else:
            writeErrors(errors)
            exit(0)
    else:
        writeErrors(["No metadata file found"])
        exit(0)

def validateSamples(directory, samples):
    errors = []
    if os.path.exists(directory):
        for sample in samples:
            sample_dir = directory + "/" + sample + "/"
            # Check directory exists
            if not os.path.exists(sample_dir):
                errors.append("{}: Sample directory does not exist".format(sample_dir))
                continue
            sample_files = os.listdir(sample_dir)
            sample_count = len(sample_files)
            if (sample_count != 2):
                errors.append("Sample {}: Expected 2 files for paired end sequencing. Found: {}".format(sample, sample_files))
                continue
            else:
                if not sample_files[0].endswith(".fastq.gz") and not sample_files[1].endswith(".fastq.gz"):
                    errors.append("Sample {}: Expected files with suffix '.fastq.gz'. Found: {}".format(sample, sample_files))
    else:
        errors.append("Couldn't find directory with input sequences")
    if len(errors) > 0:
        return False, errors
    else:
        return True, errors

def writeErrors(errors):
    fh = open("errors.txt", 'w')
    for error in errors:
        fh.write("{0}\n".format(error))
    fh.close()

def validateMetadata(filename):
    errors = []
    meta = pd.read_csv(filename, header=0)
    if not "Sample ID" in meta:
        errors.append("No Sample ID column in metadata file")
    if not "Sample Group" in meta:
        errors.append("No Sample Group column in metadata file")
    
    if len(errors) > 0:
        return False, [], errors
    else:
        return True, list(meta["Sample ID"]), errors

if __name__== "__main__":
    main()