
# SaaS Cohort Retention Analysis

## Business Problem
A SaaS subscription business needs to understand how well it retains customers
over time and identify which plans, acquisition channels, and cohorts drive
the strongest long-term retention. This project builds a complete cohort
analysis solution covering data generation, SQL analysis, Python visualisations,
and an interactive Tableau dashboard — giving product and revenue teams the
insights needed to reduce churn and grow monthly recurring revenue.

---

## Tools & Technologies
- **Python** — synthetic data generation, cohort pivot tables, retention curves
- **SQL (SQLite)** — cohort queries, window functions, revenue retention
- **Tableau Public** — interactive dashboard with action filters
- **Libraries** — pandas, numpy, matplotlib, seaborn, sqlite3

---

## Dataset
- **Source:** Synthetically generated using Python
- **Size:** 2,000 subscribers | 24 cohorts (Jan 2022 — Dec 2023)
- **Observation window:** Jan 2022 — Dec 2024
- **Plans:** Basic ($29) · Pro ($79) · Business ($149) · Enterprise ($399)
- **Channels:** Organic Search · Paid Ads · Referral · Social Media · Direct
- **Built-in patterns:** Plan-based churn rates · early tenure churn boost

---

## Project Structure

    cohort-analysis/
    │
    ├── data/
    │   ├── subscribers.csv           # Raw subscriber data
    │   ├── activity.csv              # Raw monthly activity data
    │   ├── cohort.db                 # SQLite database
    │   ├── tableau_subscribers.csv   # Tableau KPI source
    │   ├── tableau_activity.csv      # Tableau plan charts source
    │   ├── tableau_retention.csv     # Tableau heatmap source
    │   └── tableau_mrr.csv           # Tableau MRR trend source
    │
    ├── notebooks/
    │   ├── 01_setup.ipynb            # Data generation & database setup
    │   ├── 02_sql_analysis.ipynb     # SQL queries & business metrics
    │   └── 03_cohort_analysis.ipynb  # Python cohort analysis & charts
    │
    ├── sql/
    │   └── cohort_queries.sql        # All SQL queries
    │
    ├── dashboard/
    │   └── [chart exports]           # PNG exports from Python
    │
    └── README.md

---

## Methodology

### 1. Data Generation
Generated a realistic SaaS subscriber dataset using Python with 2,000
subscribers signing up across 24 monthly cohorts. Built-in churn rates
vary by plan — Enterprise churns at 2% monthly vs Basic at 8% — and
early tenure subscribers face a 30% churn boost in months 1-3 to
simulate realistic onboarding drop-off.

### 2. SQL Analysis
Wrote 9 queries covering business KPIs, cohort sizing, monthly retention
rates, MRR trends, churn by plan, revenue retention, acquisition channel
performance, and subscriber lifetime value. Used advanced SQL including
window functions (SUM OVER PARTITION BY), CTEs, and multi-table JOINs.

### 3. Python Cohort Analysis
Built the core cohort retention pivot table in pandas — grouping subscribers
by signup month and tracking what percentage remained active at each subsequent
month. Generated 6 visualisations including the signature retention heatmap,
retention curves by cohort, plan comparison lines, MRR trend, LTV curves,
and new vs churned subscribers per month.

### 4. Tableau Dashboard
Built an interactive dashboard with 7 views and action filters allowing
stakeholders to click any plan or month to filter the entire dashboard
instantly. The retention heatmap is the hero visual — showing the full
cohort retention story in a single triangle-shaped grid.

---

## Key Findings

| Finding | Detail |
|---|---|
| Average Month 1 retention | ~72% of subscribers survive their first month |
| Best retaining plan | Enterprise and Business retain significantly better than Basic |
| Highest churn risk | Basic plan subscribers in months 1-3 |
| MRR trend | Steady growth across all 36 observation months |
| Best acquisition channel | Referral channel produces highest 6-month retention |
| LTV gap | Enterprise LTV at month 12 is ~10x Basic LTV |

---

## Cohort Retention Results

    Month 0   Month 1   Month 3   Month 6   Month 12
     100%      ~72%      ~52%      ~38%       ~22%

Average retention across all 24 cohorts. The steepest drop occurs
between month 0 and month 3 — the highest risk window for churn.

---

## Business Recommendations

1. Onboarding — Improve the month 1 experience for Basic plan subscribers
   who show the steepest early churn. A 5% improvement in month 1 retention
   compounds significantly over a 12-month subscriber lifetime.

2. Upsell — Target Basic subscribers in months 1-3 with Pro upgrade offers
   before they reach peak churn risk. Pro subscribers retain at nearly
   twice the rate of Basic.

3. Channel investment — Prioritise Referral channel acquisition which
   produces the strongest 6-month retention — these subscribers are
   more engaged and higher value at signup.

4. Enterprise growth — Despite being the smallest segment Enterprise
   subscribers generate ~10x the LTV of Basic subscribers with near-zero
   churn. Even small increases in Enterprise acquisition significantly
   impact total MRR.

---

## Dashboard
View the interactive Tableau dashboard here: [SaaS Cohort Retention Analysis](https://public.tableau.com/app/profile/lynnetta.bonsu/viz/SaaSCohortRetentionAnalysis_17792889207090/SaaSCohortRetentionAnalysis)

---

## How to Run This Project

1. Clone the repo:

    git clone https://github.com/lrbonsu/cohort-analysis.git
    cd cohort-analysis

2. Install dependencies:

    pip install pandas numpy matplotlib seaborn

3. Run notebooks in order:
   - 01_setup.ipynb
   - 02_sql_analysis.ipynb
   - 03_cohort_analysis.ipynb

4. View the live Tableau dashboard at the link above

---

## Author
Lynnetta Bonsu — [LinkedIn](https://www.linkedin.com/in/lrbonsu/) | [Tableau Public](https://public.tableau.com/app/profile/lynnetta.bonsu/vizzes) | [GitHub](https://github.com/lrbonsu)
