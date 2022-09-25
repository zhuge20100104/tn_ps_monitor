from turtle import title
import pandas as pd 
from matplotlib import pyplot as plt
import os 
import datetime

RESULT_DIR = "./result"

class ReportData(object):
    def __init__(self, proc_name, df):
        self.process_name = proc_name
        self.df = df

def read_data():
    dirs = os.listdir("./result")
    reports = list()
    for dir_ in dirs:
        print(dir_)
        name_arr = dir_.split("_")
        ps_name = name_arr[0]
        res_file = os.path.join(RESULT_DIR, dir_)
        df  = pd.read_csv(res_file, header=None, delimiter="|")
        df.columns = ["Date", "Process", "CPU", "Memory"]
        report = ReportData(ps_name,  df)
        reports.append(report)
    return reports


def plot_metrics(reports):
  
    
    for idx, report in enumerate(reports):
        left_i = 1 
        right_i = 2
        process_name = report.process_name
        df = report.df
        plt.style.use('fivethirtyeight')    
        fig = plt.figure(figsize=(15, 10))
        fig.autofmt_xdate(rotation = 45)
        print(process_name)

        dates = [datetime.datetime.strptime(date, '%Y%m%d %H:%M:%S')  for date  in df["Date"]]

        ax_left = plt.subplot(1, 2,  left_i)
        ax_left.plot(dates,  df["CPU"]) 
        ax_left.set_xlabel(''); ax_left.set_ylabel('CPU'); ax_left.set_title(process_name)   

        ax_right = plt.subplot(1, 2, right_i)
        ax_right.plot(dates,  df["Memory"]) 
        ax_right.set_xlabel(''); ax_right.set_ylabel('Memory'); ax_right.set_title(process_name)   
        plt.tight_layout(pad=2)

        now_ = datetime.datetime.now()
        ts = datetime.datetime.strftime(now_, "%Y%m%d_%H%M%S")
        fig_save_path = os.path.join(RESULT_DIR, process_name  + " _" + ts + ".png")
        fig.savefig(fig_save_path)
        plt.show()
    

def main():
    reports = read_data()
    plot_metrics(reports)


if __name__ == '__main__':
    main()