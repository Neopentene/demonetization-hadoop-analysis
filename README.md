# Tweet Analysis using Hadoop and Pig
This program is to analyse and group together positive, negative and neutral tweets during the time of demonetization in India.
### Steps:
1. Create the following directories from the root directory of the project -> dataset, dictionary, results
2. Downloaded dataset from the following [kaggle link](https://www.kaggle.com/datasets/arathee2/demonetization-in-india-twitter-data)
3. Upload the downloaded dataset to the dataset directory
4. Extract the word weights from nltk word corpus
5. Upload the extracted word weights to dictionary directory created in the step 1
6. Load the data and perform analysis on the data using Pig Latin
7. Set the proper file paths in the Pig Latin Code file for the output
8. Run the Pig Latin script using the following command `pig -x mapreduce <path to the script>`
9. If the steps are followed correctly then output of the code will be generated in results directory
