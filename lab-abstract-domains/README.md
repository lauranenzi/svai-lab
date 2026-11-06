# How to over-approximate a ReLU — in-class demo

**998MG Safe and Verified AI — 2026/27 · Lectures 9–11 · Università degli Studi di Trieste**

One question, five answers: how do incomplete verifiers replace the ReLU with a convex shape?
The notebook draws and computes, on the examples of the slides:

- one ReLU on $[-1, 2]$ (L11, slides 10–11): the **box** of intervals, the **parallelogram** of zonotopes
  (DeepZ), the **triangle** of polyhedra (the LP of L08), and the **two lines** of CROWN (≈ DeepPoly),
  with their areas;
- the **running example** of Singh et al. (L09–10, slides 25–27 and 47–48; L11, slides 3 and 14–22):
  intervals prove the property on the small box and fail on the larger one, where zonotopes, the
  polyhedron and CROWN all prove it with the same bound, 1/2, against a true minimum of 1.5 (and why);
- the **CROWN example** of L11 (slides 30–38): the lower slope α decides the bound, CROWN and the same
  slope α = λ are not comparable, and α-CROWN reaches the LP bound.

Every method is written from scratch in a few lines of NumPy, with SciPy's `linprog` for the
polyhedron. This folder is self-contained, everything runs in a few seconds, no GPU needed.
**There is nothing to submit.**

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
   jupyter notebook lab_abstract_domains.ipynb
   ```

If you already have the environment of `lab-reluplex-milp` or `lab-attacks`, you can reuse it:
the notebook only needs NumPy, SciPy and Matplotlib.

## Alternative, with nothing to install: Google Colab

Open https://colab.research.google.com, choose File → Open notebook → GitHub, paste
`https://github.com/lauranenzi/svai-lab` and pick `lab-abstract-domains/lab_abstract_domains.ipynb`.
Colab already has every package. The notebook needs no data files.

## Common problems

- `ModuleNotFoundError`: the environment is not active, or the packages are not installed.
- Anything else: copy the full error message and write to me (lnenzi@units.it).

## Contents

```
lab_abstract_domains.ipynb   the notebook
check_setup.py               run this first
requirements.txt             the packages
```
