"""
lemurs.py
This file contains analysis code for lemur data.
"""

import pandas as pd
import matplotlib.pyplot as plt
import os

def get_data_files(pathparts):
    """
    This function takes an iterable of path parts (directories), 
    finds all files in that directory, and returns a list of those files.
    """
    # make full path names
    fullpath = os.path.join(*pathparts)

    datfiles = os.listdir(fullpath)
    
    # now add the fullpath to each of these file names so
    # we output a list of absolute paths
    
    output_list = [os.path.join(fullpath, f) for f in datfiles]  # whoa!
    
    return output_list

def extract_data(df):
    """
    Calculate the mean RT and Accuracy per subject for the dataframe df. 
    Return result as a data frame.
    """
    
    groupvar = 'Sub'
    colvars = ['Accuracy', 'RT']
    
    return df.groupby(groupvar)[colvars].mean()

def plot_RT_dist(df, ax):
    """
    Given a file name and axis object, plot the RT distribution for 
    each animal in the file into the axis object.
    """
    
    groupvar = 'Sub'
    colvar = 'RT'
    
    for name, grp in df.groupby(groupvar):
        grp[colvar].plot(kind='density', ax=ax, label=name.capitalize());
        
    return ax

def do_all_analysis(files):
    """
    This function plots the reaction time density for each subject in each file
    contained in the iterable files. It also calculates the mean accuracy and 
    reaction time for each subject and returns these in a data frame.
    Files should be full file paths.
    """
    
    df_pieces = []
    ax = plt.figure().gca()
    
    for f in files:
        # read in data
        df = pd.read_csv(f, index_col=0)
        
        # process summary data from df
        summary_data = extract_data(df)
        df_pieces.append(summary_data)
        
        # plot Reaction Time distribution
        plot_RT_dist(df, ax)
        
    # add legend to figure
    plt.legend(bbox_to_anchor=(1.05, 1), loc=2, borderaxespad=0.);
    
    # get figure corresponding to axis
    fig = ax.get_figure()  
    
    # concatenate all extracted dataframe pieces into one
    combined_data = pd.concat(df_pieces)
    
    # now return a tuple with the combined data frame and the figure object
    return combined_data, fig 

if __name__ == '__main__':
    pathparts = ['data', 'primates']
    flist = get_data_files(pathparts)

    summary_data, fig = do_all_analysis(flist)

    # get axis pertaining to figure
    ax = fig.gca()
    # set x-limits
    ax.set_xlim(0, 6);

    fig.savefig('lemurfig.pdf', bbox_inches='tight')

    summary_data.to_csv('summary_data.csv')


