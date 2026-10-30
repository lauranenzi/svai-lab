# Reluplex and MILP on an ACAS Xu–style property — in-class demo

**998MG Safe and Verified AI — 2026/27 · Lecture 8 · Università degli Studi di Trieste**

Exercise 2 of Lecture 8 (slide 59), solved with code. A network with two inputs, two ReLUs and one
output, and the property *y ≤ 1500* on an input box. The notebook answers the four questions of the
slide and then compares the methods:

- the bounds of the pre-activations, and which ReLU is stable (interval arithmetic);
- the satisfiability query in **Z3**, and the same query split by hand on the unstable ReLU, as
  Reluplex does;
- the **MILP** with big-M (one binary) and its **LP relaxation**, with `scipy.optimize.milp`;
- intervals, LP and MILP side by side on three variants of the property.

This folder is self-contained. Everything runs in a few seconds, no GPU needed.
**There is nothing to submit**: the questions at the end are for the next class.

## Setup (5 minutes)

1. **Python 3.10 or newer** (`python3 --version`).
2. Open a terminal **inside this folder**.
3. **Create and activate a virtual environment**, then install the packages:

   macOS / Linux:
   ```
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```
   Windows (PowerShell):
   ```
   py -m venv .venv
   .venv\Scripts\Activate.ps1
   pip install -r requirements.txt
   ```
4. **Check that it works**:
   ```
   python check_setup.py
   ```
   It must end with `All good`.
5. **Open the notebook**:
   ```
   jupyter notebook lab_reluplex_milp.ipynb
   ```

If you already have the environment of `lab-attacks`, you can reuse it: `pip install z3-solver scipy`
is all it needs.

## Alternative, with nothing to install: Google Colab

Open https://colab.research.google.com, choose File → Open notebook → GitHub, paste
`https://github.com/lauranenzi/svai-lab` and pick `lab-reluplex-milp/lab_reluplex_milp.ipynb`.
Uncomment the `%pip install` line in the first code cell and run the notebook from the top. The
notebook needs no data files.

## Common problems

- `ModuleNotFoundError: No module named 'z3'`: the environment is not active, or `z3-solver` is not
  installed. The package is called `z3-solver`; `pip install z3` installs something else.
- `cannot import name 'milp'`: SciPy is older than 1.9. `pip install -U scipy`.
- Anything else: copy the full error message and write to me (lnenzi@units.it).

## The SMT and LP programs of the lecture

`data/` holds the SMT-LIB2 programs shown in class (`exercise1.smt2`, `exam_slots.smt2`,
`robot.smt2`). Run them with `z3 <file>` (the `z3` command comes with `pip install z3-solver`), or
paste them into the online Z3 playground. The second notebook, `lab_smt_lp.ipynb`, runs them all
and solves the scheduler and the robot a second time, with MILP and LP.

## Contents

```
lab_reluplex_milp.ipynb             the notebook
lab_smt_lp.ipynb                    the SMT programs of the lecture, two of them also with MILP / LP
check_setup.py                      run this first
requirements.txt                    the packages
data/                               the SMT-LIB2 programs of the lecture (Z3)
```
