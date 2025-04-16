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

3.  **Data Loading (Optional):**  A Cloud Function is triggered when the CSV file is created in Cloud Storage. This function loads the data into a new table in BigQuery.

4.  **Data Visualization:** Looker is connected to BigQuery, allowing users to explore the aggregated crime data and create visualizations such as:
    *   Line graphs showing crime trends over time.
    *   Bar charts highlighting the most common crime types.
    *   Tables summarizing crime statistics by year and type.

## Repository Structure
