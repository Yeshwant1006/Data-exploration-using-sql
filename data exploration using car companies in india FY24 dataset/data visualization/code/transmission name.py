import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

model_transmission_count = df.groupby(['model_name', 'transmission_name']).size().unstack(fill_value=0)

plt.figure(figsize=(30, 40))
for idx, row in model_transmission_count.iterrows():
    plt.plot([row.idxmin(), row.idxmax()], [idx, idx], 'o', markersize=12)

plt.title('Transmission Type Distribution by Car Model', fontsize=30)
plt.xlabel('Transmission Type', fontsize=28)
plt.ylabel('Car Model', fontsize=28)
plt.xticks(fontsize=16, rotation = 90)
plt.yticks(fontsize=16)
plt.tight_layout()

plt.show()
