"""Setup check: python check_setup.py  (run it from the lab folder)."""
import sys

def fail(msg):
    print("\n[ERROR]", msg); sys.exit(1)

print("Python", sys.version.split()[0])
if sys.version_info < (3, 10):
    fail("Python 3.10 or newer is needed.")
try:
    import numpy, matplotlib, scipy
except ImportError as e:
    fail(f"missing package ({e.name}). Did you activate the environment and run "
         f"'pip install -r requirements.txt'?")
print("scipy", scipy.__version__, "| numpy", numpy.__version__, "| matplotlib", matplotlib.__version__)

# a one-variable LP: max x  s.t.  x <= 1.5  ->  x = 1.5
from scipy.optimize import linprog
res = linprog([-1], A_ub=[[1]], b_ub=[1.5], bounds=[(0, 10)])
if not (res.success and abs(res.x[0] - 1.5) < 1e-9):
    fail("scipy.optimize.linprog runs but returns a wrong answer.")

print("\nAll good. You can open lab_abstract_domains.ipynb.")
