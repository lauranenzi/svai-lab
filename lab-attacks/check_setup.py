"""Setup check: python check_setup.py  (run it from the lab folder)."""
import os, sys

def fail(msg):
    print("\n[ERROR]", msg); sys.exit(1)

print("Python", sys.version.split()[0])
try:
    import torch, torchvision, matplotlib, numpy
except ImportError as e:
    fail(f"missing package ({e.name}). Did you activate the environment and run "
         f"'pip install -r requirements.txt'?")
print("torch", torch.__version__, "| torchvision", torchvision.__version__)

for p in ("models/model_cnn.pt", "models/model_cnn_robust.pt", "models/model_dnn_2.pt", "data/MNIST/raw"):
    if not os.path.exists(p):
        fail(f"cannot find '{p}'. Run this script from the folder that contains "
             f"lab_attacks.ipynb, models/ and data/.")

import torch.nn as nn
from torchvision import datasets, transforms
class Flatten(nn.Module):
    def forward(self, x): return x.view(x.shape[0], -1)
cnn = nn.Sequential(nn.Conv2d(1,32,3,padding=1), nn.ReLU(), nn.Conv2d(32,32,3,padding=1,stride=2), nn.ReLU(),
                    nn.Conv2d(32,64,3,padding=1), nn.ReLU(), nn.Conv2d(64,64,3,padding=1,stride=2), nn.ReLU(),
                    Flatten(), nn.Linear(7*7*64,100), nn.ReLU(), nn.Linear(100,10))
cnn.load_state_dict(torch.load("models/model_cnn.pt", map_location="cpu")); cnn.eval()
test = datasets.MNIST("./data", train=False, download=False, transform=transforms.ToTensor())
X = torch.stack([test[i][0] for i in range(200)]); y = torch.tensor([test[i][1] for i in range(200)])
with torch.no_grad(): acc = (cnn(X).argmax(1) == y).float().mean().item()
print(f"CNN accuracy on 200 images: {acc:.2f}  (expected ~0.99)")
if acc < 0.9: fail("accuracy too low: the model or data files are not the right ones.")
print("\nAll good. You can open lab_attacks.ipynb.")
