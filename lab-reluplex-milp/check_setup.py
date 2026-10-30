"""Setup check: python check_setup.py  (run it from the lab folder)."""
import sys

def fail(msg):
    print("\n[ERROR]", msg); sys.exit(1)

print("Python", sys.version.split()[0])
if sys.version_info < (3, 10):
    fail("Python 3.10 or newer is needed.")
try:
    import numpy, matplotlib, scipy, z3
except ImportError as e:
    fail(f"missing package ({e.name}). Did you activate the environment and run "
         f"'pip install -r requirements.txt'?")
print("z3", z3.get_version_string(), "| scipy", scipy.__version__, "| numpy", numpy.__version__)

try:
    from scipy.optimize import milp, LinearConstraint, Bounds
except ImportError:
    fail("scipy.optimize.milp not found: SciPy 1.9 or newer is needed (pip install -U scipy).")

# a one-variable MILP: max x  s.t.  x <= 1.5,  x integer  ->  x = 1
res = milp([-1], constraints=LinearConstraint([[1]], -numpy.inf, 1.5), bounds=Bounds(0, 10), integrality=[1])
if not (res.success and round(res.x[0]) == 1):
    fail("scipy.optimize.milp runs but returns a wrong answer.")

# a one-line SMT query: is there a real x with 1 < x < 2?
x = z3.Real("x"); s = z3.Solver(); s.add(x > 1, x < 2)
if s.check() != z3.sat:
    fail("Z3 runs but returns a wrong answer.")

print("\nAll good. You can open lab_reluplex_milp.ipynb.")
