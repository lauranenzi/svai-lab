# Adversarial attacks on MNIST — in-class demo and take-home exercise

**998MG Safe and Verified AI — 2026/27 · Lecture 2 · Università degli Studi di Trieste**

This folder is self-contained: the notebook, the three pre-trained networks, the MNIST test data and
the setup check are all here, and nothing outside it is needed. Work from inside `lab-attacks/`.

Open `lab_attacks.ipynb`, run it from the top, fill in the few lines marked `FILL_IN`, and answer the
questions in Section 6. Sections 1–5 are the demo we went through in class; Section 6 is the
exercise you do on your own.

**There is nothing to submit.** Bring the notebook with the cells executed and the answers written
in, and we discuss it in the next class. Expect about 90 minutes. No GPU needed: the models come
pre-trained and a full run takes about 5 minutes on a laptop.

## Notation

The same as the slides, so you can read one next to the other.

| symbol | meaning |
|---|---|
| $f : [0,1]^d \to \mathbb{R}^k$ | the network, raw scores, no softmax |
| $f_j(x)$ | the score of class $j$ |
| $y$ | the true class |
| $\eta$ | the perturbation; the adversarial example is $x' = x_0 + \eta$ |
| $C_p(x_0,\varepsilon)$ | the allowed set: every $x$ in $[0,1]^d$ with $\lVert x - x_0 \rVert_p \le \varepsilon$ |
| $f(x) = f_y(x) - \max_{j \ne y} f_j(x)$ | the margin — the property is $f(x) > 0$ |
| $y^\star = \min \{ f(x) : x \in C_p(x_0,\varepsilon) \}$ | the property holds exactly when $y^\star > 0$ |

An attack returns one point, so it gives an **upper** bound on $y^\star$: $\le 0$ means falsified,
above $0$ means we have learned nothing. A verifier gives a **lower** bound. Counterexample and
adversarial example are the same thing.

## Setup (5–10 minutes)

1. **Python 3.10 or newer** (`python3 --version`). If you do not have it: https://www.python.org/downloads/
2. Open a terminal **inside this folder** (the one containing `lab_attacks.ipynb`).
3. **Create and activate a virtual environment**, then install the packages (a 200–800 MB download,
   depending on your system):

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
   (If PowerShell blocks the activation script, use the Command Prompt and `.venv\Scripts\activate.bat`.)
4. **Check that it works**:
   ```
   python check_setup.py
   ```
   It must end with `All good`.
5. **Open the notebook**:
   ```
   jupyter notebook lab_attacks.ipynb
   ```

## Alternative, with nothing to install: Google Colab

Open https://colab.research.google.com, choose File → Open notebook → GitHub, paste
`https://github.com/lauranenzi/svai-lab` and pick `lab-attacks/lab_attacks.ipynb`. That opens only
the notebook, so before anything else add a cell at the top with:

```
# download the whole repository into the Colab machine (notebook, models/, data/)
!git clone https://github.com/lauranenzi/svai-lab.git
# move into the lab folder, so that the paths models/ and data/ are found
%cd svai-lab/lab-attacks
```

This brings in `models/` and `data/`; then run the notebook from the top. On Colab `torch` is
already there. Installing locally is only worth it if you want to work offline.

## The sanity checks

Two cells contain `assert` statements — one after your PGD implementation, one after the exercise
function. They stop the notebook with an explanatory message if your code is wrong, so that you do
not end up with plots that look plausible but are not. If one fires, read the message: it names the
mistake. The two usual ones are a forgotten projection onto the ball and a missing clamp to $[0,1]$.

## Common problems

- `ModuleNotFoundError`: the environment is not active. Redo step 3 (the `source`/`Activate` line)
  and try again.
- `cannot find 'models/...'`: you are running from the wrong folder. Move to the one containing
  `models/` and `data/`.
- The notebook is too slow: lower `range(500)` to `range(200)` in the data cell.
- Anything else: copy the full error message and write to me (lnenzi@units.it).

## Contents

```
lab_attacks.ipynb             the notebook you work on
check_setup.py                run this first
requirements.txt              the packages
models/                       cnn, cnn_robust, dnn — already trained
data/                         MNIST
```
