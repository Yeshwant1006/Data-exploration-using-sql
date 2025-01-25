import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_excel('file path')

filtered_df = df[df['fuel_type'] != 'Electric']

plt.figure(figsize=(50, 30))
plt.scatter(filtered_df['engine_displacement'], filtered_df['engine_capacity'], color='orange', s=1000)

plt.title('Engine Analysis', fontsize=36)
plt.xlabel('Engine Displacement (L)', fontsize=24)
plt.ylabel('Engine Capacity (cc)', fontsize=24)
plt.xticks(fontsize=20, rotation=90)
plt.yticks(fontsize=20)
plt.tight_layout()

plt.show()
