import pandas as pd
import matplotlib.pyplot as plt
import re
from matplotlib.ticker import FuncFormatter

df = pd.read_excel('file path')

def convert_price_range(price_range):
    match = re.match(r'(\d+)([A-Za-z]+) to (\d+)([A-Za-z]+)', price_range)
    if match:
        lower_value = int(match.group(1))
        upper_value = int(match.group(3))
        unit = match.group(2)

        if unit == "L":
            lower_value *= 100000
            upper_value *= 100000
        elif unit == "CR":
            lower_value *= 10000000
            upper_value *= 10000000

        return (lower_value + upper_value) / 2
    else:
        match = re.match(r'(\d+)([A-Za-z]+)', price_range)
        if match:
            value = int(match.group(1))
            unit = match.group(2)
            if unit == "L":
                value *= 100000
            elif unit == "CR":
                value *= 10000000
            return value
        else:
            return None

df['ex_showroom_price_from'] = df['ex_showroom_price_from'].apply(convert_price_range)
df['on_road_price_from'] = df['on_road_price_from'].apply(convert_price_range)

avg_prices = df.groupby('company_name')[['ex_showroom_price_from', 'on_road_price_from']].mean()

def format_y_ticks(x, pos):
    if x >= 10000000:
        return f'{x / 10000000:.1f} Cr'
    elif x >= 100000:
        return f'{x / 100000:.1f} L'
    else:
        return f'{x:.0f}'

fig, ax = plt.subplots(figsize=(10, 8))
avg_prices.plot(kind='bar', ax=ax)

ax.yaxis.set_major_formatter(FuncFormatter(format_y_ticks))

ax.set_ylim(500000, 20000000)

plt.title('Average Pricing Comparison Across Brands', fontsize = 16)
plt.xlabel('Company Name', fontsize = 12)
plt.ylabel('Average Price', fontsize = 12)

plt.xticks(fontsize = 10, rotation=90)
plt.yticks(fontsize = 10)

plt.tight_layout()

plt.show()
