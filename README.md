# GCP_Pipeline

# Chicago Crime Data Analysis Pipeline on GCP

This repository contains the code and configuration for a data analysis pipeline built on Google Cloud Platform (GCP) to analyze Chicago crime data. This project aims to provide insights into crime trends and patterns, allowing for data-driven decision-making in public safety.

## Business Problem

The city of Chicago faces ongoing challenges in managing and reducing crime. Understanding crime trends, hotspots, and common crime types is crucial for resource allocation, crime prevention strategies, and overall public safety improvement. This project addresses the need for accessible and actionable insights from the vast amount of crime data available.

## Technical Solution

This project utilizes a robust and scalable data pipeline on GCP to process, analyze, and visualize Chicago crime data.  The solution leverages the following GCP services:

*   **BigQuery:** Serves as the data warehouse, storing the public Chicago crime dataset (`bigquery-public-data.chicago_crime.crime`). This provides a centralized and scalable repository for all crime-related information.

*   **Dataproc:** Enables distributed data processing using Apache Spark.  Spark is used to aggregate and transform the raw crime data, creating summaries and identifying trends.

*   **Cloud Storage:** Acts as a staging area for storing Spark scripts, intermediate data, and the output of the Dataproc jobs.  This ensures data persistence and facilitates data transfer between GCP services.

*   **Looker:** Provides a powerful visualization and exploration platform. Looker connects to BigQuery to allow users to interactively explore the processed crime data and generate custom dashboards.

*   **[Optional] Cloud Functions:** Automates the data loading process. Upon completion of the Dataproc job, a Cloud Function is triggered to load the processed data from Cloud Storage into BigQuery.

## Pipeline Overview

The data pipeline consists of the following steps:

1.  **Data Ingestion:** The raw Chicago crime data resides in the `bigquery-public-data.chicago_crime.crime` table in BigQuery.

2.  **Data Processing:** A Spark script (`crime_analysis.py`) is executed on a Dataproc cluster. This script performs the following operations:
    *   Extracts the year from the crime date.
    *   Aggregates the crime data by year and primary crime type.
    *   Writes the aggregated results to a CSV file in Cloud Storage.

3.  **Data Visualization:** Looker is connected to BigQuery, allowing users to explore the aggregated crime data and create visualizations such as:
    *   Line graphs showing crime trends over time.
    *   Bar charts highlighting the most common crime types.
    *   Tables summarizing crime statistics by year and type.


## Preliminary Data Analysis Summary: Chicago Crime Dataset

This preliminary analysis focuses on providing a descriptive overview of the Chicago Crime Dataset (`bigquery-public-data.chicago_crime.crime`). We examined the dataset to understand its structure, identify key variables, and uncover initial insights into crime patterns.

**Descriptive Analysis:**

*   **Temporal Distribution:** Crime incidents exhibit a clear temporal distribution. Initial observations suggest a decline in overall crime rates over the past decade (2010s compared to 2000s), but this requires further investigation to account for potential data inconsistencies or reporting changes.  There are also likely seasonal variations within each year, requiring further analysis of monthly or even weekly crime trends.

*   **Geographic Hotspots:**  The dataset includes location information (latitude and longitude) allowing for the identification of crime hotspots.  Certain areas consistently exhibit higher crime rates than others. Further analysis should incorporate demographic data and contextual factors to understand the underlying causes of these hotspots.

*   **Crime Type Distribution:** The 'Primary Type' and 'Description' fields provide valuable information on the types of crimes committed.  The initial exploration reveals that 'THEFT', 'BATTERY', and 'NARCOTICS' are among the most frequently reported crime types. A deeper dive is necessary to understand the specific subcategories within each crime type and their prevalence.

*   **Arrest Rates:** The 'Arrest' boolean field indicates whether an arrest was made in connection with a particular crime.  Analysis of arrest rates across different crime types and geographic areas can reveal potential biases or inefficiencies in law enforcement.

*   **Domestic Violence:** The 'Domestic' boolean field indicates whether a crime was classified as domestic violence related. Understanding the prevalence and characteristics of domestic violence incidents is critical for targeted prevention and intervention strategies.

**Key Observations and Questions:**

*   **Data Quality:**  Further data cleaning and validation are necessary to address potential inconsistencies or missing values, particularly in the location fields.

*   **Correlation vs. Causation:** While the analysis can reveal correlations between various factors (e.g., demographics and crime rates), it's crucial to avoid inferring causation without further rigorous investigation.

*   **External Factors:**  The analysis should consider incorporating external data sources, such as economic indicators, housing statistics, and social services availability, to gain a more comprehensive understanding of the factors influencing crime rates.

**Recommendations (Ranked by Priority):**

1.  **Data Cleaning and Validation (High):** Prioritize cleaning and validating the location data and addressing any missing values in key fields. This ensures data integrity and the accuracy of subsequent analyses.

2.  **Temporal Trend Analysis (High):** Conduct a detailed analysis of crime trends over time, controlling for potential confounding factors such as reporting changes or shifts in law enforcement strategies. Examine monthly and weekly patterns.

3.  **Hotspot Mapping and Analysis (Medium):** Develop interactive maps of crime hotspots and integrate demographic data to identify potential contributing factors. Explore clustering techniques to identify distinct types of crime-ridden areas.

4.  **Crime Type Categorization and Hierarchy (Medium):**  Establish a clear categorization and hierarchy of crime types based on the 'Primary Type' and 'Description' fields to enable more granular analysis and targeted interventions.

5.  **Arrest Rate Disparity Analysis (Medium):**  Investigate potential disparities in arrest rates across different demographics and crime types to identify potential biases in law enforcement.

6.  **Domestic Violence Incident Analysis (Low):**  Conduct a detailed analysis of domestic violence incidents, including temporal trends, geographic distribution, and victim characteristics, to inform targeted prevention and support programs.

7.  **Integration of External Data Sources (Low):** Incorporate external data sources, such as economic indicators, housing statistics, and social services availability, to gain a more comprehensive understanding of the factors influencing crime rates. This step is dependent on the completion of the higher priority tasks.

These recommendations provide a starting point for a more in-depth investigation into the Chicago Crime Dataset. Addressing these issues will enhance the quality and reliability of the analysis, enabling more informed decision-making and effective crime prevention strategies.
