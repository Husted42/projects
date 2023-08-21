import os
import shutil
import schedule
import time

''' If list is added, also add to categorize '''
folderLst = ['Pictures', 'Text', 'MicrosoftDocuments', 'Compressed', 'Data', 'Executable', 'Programming', 'Other']
Pictures = ['jpeg', 'png', 'gif', 'tiff', 'tif', 'psd', 'eps', 'ai', 'indd', 'raw', 'bmp', 'jpg', 'svg', 'webp']
Text = ['pdf', 'txt']
MicrosoftDocuments = ['doc', 'docx', 'rtf', 'xls', 'xlsx', 'ppt', 'pptx', 'xps']
Compressed = ['7z', 'arj', 'deb', 'pkg', 'rar', 'rpm', 'tar.gz', 'z', 'zip']
Data = ['csv', 'dat', 'db', 'dbf', 'log', 'mdb', 'sav', 'sql', 'tar', 'xml']
Executable = ['apk', 'bat', 'bin', 'cgi', 'pl', 'exe', 'gadget', 'jar', 'msi', 'wsf']
Programming  = ['c', 'cgi', 'class', 'cpp', 'cs', 'h', 'java', 'php', 'py', 'sh', 'swift', 'vb', 'fsx', 'fs', 'fsi', 'fsproj', 'ipynb']

path_ = '.../Program - Folder cleaner'

def categorize(inp):
    ''' 
    categorize selects designated folder

    :param inp: name of file with type (file.txt)
    :return: designated folder name
    '''
    if inp in Pictures: return 'Pictures'
    if inp in Text: return 'Text'
    if inp in MicrosoftDocuments: return 'MicrosoftDocuments'
    if inp in Compressed: return 'Compressed'
    if inp in Data: return 'Data'
    if inp in Executable: return 'Executable'
    if inp in Programming: return 'Programming'
    return 'Other'

def duplicateFixer(elm, dest, n):
    '''
    duplicateFixer changes filename to filename(n)

    :param elm: name of file (file.txt)
    :param dest: path to designated folder
    :param n: default 0, incremt by one each time function is called 
    :return: New file name
    '''
    elmInDest = os.listdir(dest)
    if elm in elmInDest:
        name, type = os.path.splitext(elm)
        name = name + '({})'.format(n)
        file = name + type
        if file in elmInDest:
            return duplicateFixer(elm, dest, n+1)
        else: 
            return file
    else: 
        print('return elm')
        return elm


def cleanFolder():
    ''' 
    cleanFolder is the main function that iterates through every element in directory, 
    and move them to designated folder.
    
    elm = name of file with type sepecification (file.txt)
    elm_ = File after duplicate fix (file(n).txt)
    foldername = Name of the folder the file should be placed in 
    :returns: None
    '''
    fileTypes = [] #List of all distinct file types in dir 
    files = os.listdir(path_) #List of all files in dir
    files.remove('cleanDownload.py')
    for elm in files:
        foldername = ''
        if (os.path.splitext(elm))[1] != '': #Check if element is a folder
            fileSplit = os.path.splitext(elm)
            filetype = (fileSplit[1])[1:] #Filetype minus .
            if fileSplit[1] not in fileTypes: fileTypes.append(fileSplit[1]) #Get distinct
            foldername = categorize(filetype)
        else:
            if elm not in folderLst:
                foldername = 'Folders'
        if foldername != '':
            src = path_ + '/' + elm
            dest = path_ + '/' + foldername 
            if foldername not in os.listdir(path_): os.mkdir(dest, 0o666)
            elmInDest = os.listdir(dest)
            #If file already exists
            if elm in elmInDest:
                elm_ = duplicateFixer(elm, dest, 0)
                os.rename(elm, elm_)
                src = path_ + '/' + elm_
            shutil.move(src, dest)
            print('Moved file : {} --> {}'.format(elm, foldername))

cleanFolder() #Run startup
schedule.every().hour.do(cleanFolder)

''' Keeps the script running '''
while True:
    schedule.run_pending()
    time.sleep(1)