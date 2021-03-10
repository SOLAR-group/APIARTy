# APIARTy

APIARTy is an automated pipeline for evaluating and comparing automated program repair tools (repair tools) that can potentially detect and fix API misuses in Java programs. APIARTy currently includes MUBench, Bears, and Bugs.jar as bug benchmarks and state-of-the-art repair tools including Arja, Astor, Nopol, NPEFix, Avatar, TBar, and SimFix.

This repository accompanies the paper Evaluating Automatic Program Repair Capabilities to Repair API Misuses.

## Goals

* Execution of 14 repair tools on API misuses extracted from three bug benchmarks.
* Comparison of the repair tools on their effectiveness and efficiency on repairing API misuses.
* Examination of the effect of different API-misuse categories on the capabilities of API-repair tools.

## Selected repair tools

| #  | Tool             | Language | Repository                             | Checkout SHA |
| -- | ---------------  | -------- | -------------------------------------  | ------------ |
| 1  | Nopol            | Java     | https://github.com/SpoonLabs/nopol     | bf4a92f      |
| 2  | DynaMoth         | Java     | https://github.com/SpoonLabs/nopol     | bf4a92f 	   |
| 3  | NPEFix           | Java     | https://github.com/SpoonLabs/npefix    | 80cfc38      |
| 4  | jGenProg         | Java     | https://github.com/SpoonLabs/Astor     | da8a267      |
| 5  | jKali            | Java     | https://github.com/SpoonLabs/Astor     | da8a267      |
| 6  | jMutRepair       | Java     | https://github.com/SpoonLabs/Astor     | da8a267      |
| 7  | Cardumen         | Java     | https://github.com/SpoonLabs/Astor     | da8a267      |
| 8  | ARJA             | Java     | https://github.com/yyxhdy/arja         | 3e01305      |
| 9  | ARJA-GenProg     | Java     | https://github.com/yyxhdy/arja         | 3e01305      |
| 10 | ARJA-RSRepair    | Java     | https://github.com/yyxhdy/arja         | 3e01305      |
| 11 | ARJA-Kali        | Java     | https://github.com/yyxhdy/arja         | 3e01305      |
| 12 | Avatar           | Java     | https://github.com/SerVal-DTF/AVATAR   | 68a1386      |
| 13 | TBar             | Java     | https://github.com/SerVal-DTF/TBar     | d1b1555      |
| 14 | SimFix           | Java     | https://github.com/xgdsmileboy/SimFix  | c2a5319      |

## Used bug benchmarks

| # | Benchmark      | Language | # Projects | # Bugs | # API Misuses | # Final Projects | Link                                           |
| - | -------------- | -------- | ----------:| ------:| -------------:| ----------------:| ---------------------------------------------  |
| 1 | Bears          | Java     |         72 |    251 |            19 |				 10  | https://github.com/bears-bugs/bears-benchmark  |
| 2 | Bugs.jar       | Java     |          8 |  1,159 | 	       40 |				  7	 | https://github.com/bugs-dot-jar/bugs-dot-jar   | 
| 3 | MUBench        | Java     |         68 |    280 | 	       42 |				 12	 | https://github.com/stg-tud/MUBench             |
|   | **Total**      |          |        148 |  1,690 |           101 |               29 |                                                |

## Usage

To deploy and use APIARTy, you need to install Docker. If you use APIARTy on a desktop, get Docker Desktop from the following link:

- https://www.docker.com/products/docker-desktop

### Set-up and deployment

To build a Docker image of this repository and run it on Docker you need to follow the next instructions:

- `git clone https://github.com/mkechagia/APIARTy.git`
- `cd APIARTy`
- `docker build -t apiarty .`
- `docker run -it -v apiarty-findings:/apiarty/findings --rm apiarty` or
- `docker run -it -v <absolute_path_to_store_results>:/apiarty/findings --rm apiarty` (it locally stores the results).
- Also, the following command can be used for keeping locally the data (buggy projects) `docker run -it -v <absolute_path_to_store_results>:/apiarty/findings -v <absolute_path_to_store_results>:/apiarty/data --rm apiarty`.

For more information about Docker, please check the following links:

- https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- https://docs.docker.com/engine/reference/run/

### Running APIARTy

`data/*.json` contains the projects' meta-data required by most repair tools. Easily you can add more `.json` files (i.e., projects) to detect and repair any bugs. The whole process can run on one project or on all. Just give the right commands presented in the following.

1. To run an experiment on one project e.g., Bears-84, using one tool e.g., Kali, give the following command:

- `./apiarty Arja-Kali Bears-84`

2. To analyse all the projects that exist in `data` using a particular repair tool e.g., Kali, give the following command:

- `./apiarty Arja-Kali`

3. To run all tools (Arja, Astor, Nopol and NPEFix) on a project e.g., Bears-84, give the following command:

- `./apiarty ALL Bears-84`

4. To run Avatar, TBar, or SimFix, apply the guidelines included in the `guidelines.txt` as these tools strictly use Defects4J commands.

## Execution environment

All experiments run on an Ubuntu 16.04 Linux Docker image of APIARTy
deployed on a 2-core PC with 8GB RAM and 3,1 GHz Intel Core i5 processor.
We used Java 1.8 (amd64) ofthe OpenJDK, allocating up to 4GB for the JVM.

## Repository structure

This repository is structured as follows:

```
APIARTy
├── Dockerfile
├── README.md
├── apiarty
├── apiarty.bin
│   ├── apiarty
│   └── bashrc
├── data
│   └── <bug_id>.json: standard input (with project metadata)
├── findings
│   ├── <bug_id>
│   │   └── <repair tool>
│   │       ├── stderr.txt: stderr of the execution (with repair)
│   │       └── stdout.txt: stdout of the execution (with repair)
│   ├── <bug_id>_simfix.txt: repair log of SimFix
│   ├── <bug_id>_avatar.txt: repair log of Avatar
│   ├── <bug_id>_tbar.txt: repair log of TBar
│   ├── all-results.csv: execution time taken by the repair attempts (without those that reach the timeout)
│   └── timeout.csv: repair attempts that failed by timeout
└── guidelines
    ├── Avatar
    │   ├── AbstractFixer.java
    │   ├── Configuration.java
    │   └── FLFix.sh
    └── guidelines.txt: specific guidelines for running Avatar, TBar, and SimFix
```
