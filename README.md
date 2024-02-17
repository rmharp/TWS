
# MH Project README

## Overview
This project focuses on analyzing a survey conducted to understand student mental health outcomes. It uses R and several packages for data manipulation, visualization, and statistical analysis. The project aims to identify trends, patterns, and potential areas of concern regarding student mental health based on survey responses.

# The Whole Student (TWS)
## Project Description
The analysis pipeline is implemented in R Markdown, facilitating a reproducible research workflow. It includes data cleaning, transformation, and visualization steps, specifically targeting survey data on student mental health outcomes.

## Data Sources
The survey data should be placed in a `./data/` directory within the project folder. Ensure the file is named according to the `filename` variable in the R Markdown document. The survey data should be in CSV format.

## Installation and Dependencies
To run the analysis, ensure you have R installed on your system, along with the following R packages:
- `MASS`
- `dplyr`
- `readr`
- `ppsr`
- `likert`

These packages can be installed using the provided code in the R Markdown setup chunk.

## Usage
1. Place your survey data CSV in the `./data/` directory within your project folder.
2. Open the R Markdown file (`MH Project.Rmd`) in an R-compatible IDE (e.g., RStudio).
3. Run the code chunks sequentially to perform the analysis.

## Key Functions
- **Data Cleaning:** Prepares the dataset for analysis by renaming variables, filtering responses, and converting data types as necessary.
- **Visualization:** Generates plots to visualize the distribution of responses and correlations among survey items.
- **Statistical Analysis:** Applies predictive posterior sampling and correlation analysis to explore relationships within the data.

## Contributions
This project is designed as a part of an educational or research initiative to better understand student mental health.

## License
This project is open-sourced under the MIT License.

## Acknowledgements
Thanks to all contributors and participants of the survey for providing insights into student mental health. Special thanks to the educators and researchers who have guided the development of this project.
