from tkinter import *
from tkinter import ttk
from PIL import ImageTk,Image
from os import *
import os
import sys

is_manhwa = True

increment = 0
i = 0
my_option = 0
chap_num = 0
my_dir = "NULL"
in_dir = {}

for item in sys.argv:
    is_option = "-" in item
    is_dir = "/" in item
    is_py = ".py" in item
    is_photo = ".j" in item or ".pn" in item or ".w" in item
    is_number = type(item)

    if os.path.isdir(item):
        if item[-1] != '/':
            item = item + '/'

    if is_option == False and is_dir == False and is_py == False:
        chap_num = item 
        chap_num = int(chap_num)
        chap_num = chap_num - 1

    if is_option == True and is_py == False:
        my_option = 1


    if is_option == False and is_dir == True and is_py == False and is_photo == True:
        my_dir = "NULL"
        in_dir[increment] = item

    if is_option == False and is_py == False and os.path.isdir(item) == True:

        files = listdir(item)
        files.sort()
        for child in files:
            if os.path.isdir(item + "/" + child):
                my_dir = item
            else:
                my_dir = "NULL"
                in_dir[increment] = item + "/" + child
                increment = increment + 1


    increment = increment + 1

def xory(speed = 10):
    if is_manhwa:
        my_canvas.yview_scroll(speed, "units")
    else:
        my_canvas.xview_scroll(speed, "units")

def mousewheel_up(event):
    xory(10)

def mousewheel_down(event):
    xory(-10)


def on_exit(event):
    sys.exit()

    
#if my_dir == "NULL" and in_dir[0] == "NULL":
#    print("provide the directory")
#    sys.exit()

def mainthing():
    global on, my_canvas, root, my_scrollbar, my_dir, filesindir, filesindir_length
    root = Tk()
    root.title('Manhwa Reader')
    root.configure(background='black')
    root.geometry('700x1000')
    root.bind("<Button-5>" , mousewheel_up)
    root.bind("j" , mousewheel_up)
    root.bind("<Button-4>" , mousewheel_down)
    root.bind("k" , mousewheel_down)
    root.bind("q" , on_exit)
    on = 1

    main_frame = Frame(root)
    main_frame.pack(fill=BOTH, expand=1)

    
    if is_manhwa:
        my_canvas = Canvas(main_frame, yscrollincrement=2)
    else:
        my_canvas = Canvas(main_frame, xscrollincrement=2)

    if my_option == 1:

            if is_manhwa:
                my_canvas.pack(side=LEFT ,fill=BOTH, expand=1)
                my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
                my_scrollbar.pack(side=RIGHT, fill=Y)
            else:
                my_canvas.pack(side=TOP ,fill=BOTH, expand=1)
                my_scrollbar = ttk.Scrollbar(main_frame, orient=HORIZONTAL, command=my_canvas.xview)
                my_scrollbar.pack(side=BOTTOM, fill=X)

    else:
        my_canvas.pack(fill=BOTH, expand=1)
        if is_manhwa:
             my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
        else:
             my_scrollbar = ttk.Scrollbar(main_frame, orient=HORIZONTAL, command=my_canvas.xview)


    
    my_canvas.configure(yscrollcommand=my_scrollbar.set)
    my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion = my_canvas.bbox("all")))
    
    second_frame = Frame(my_canvas)
    my_canvas.create_window((0,0), window=second_frame, anchor="nw")

    mypath = my_dir

    if my_dir == "NULL":
        in_dir_length = len(in_dir)
        filesindir_length = in_dir_length

        dir_format = {}
        for i in range(1, in_dir_length + 1, 1):
            dir_format[i] = in_dir[i]
    else:
        maindir = listdir(mypath)
        maindir.sort()
        filesindir = listdir(my_dir + "/" + str(maindir[chap_num]))
        filesindir.sort()
        filesindir_length = len(filesindir)

    i = 1 
    add = i + 1
    dec = i - 1
    a = {}
    b = {}
    if is_manhwa == False:

        def somefunc(somevar = True):

            if somevar:
                i = i + 1
            else:
                i = i - 1

            if type(dir_format) is dict:
                  a[i] = Image.open(dir_format[i])
            else:
                  a[i] = Image.open(dir_format)
              
            a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)
            
            b[i] = ImageTk.PhotoImage(a[i])
            if is_manhwa:
                Label(second_frame, image=b[i]).grid(row=i, column=0, sticky="nsew")
            else:
                Label(second_frame, image=b[i]).grid(row=0, column=i, sticky="nsew")

        somefunc()
        
    else:

        for i in range(0, filesindir_length, 1):
        
            if my_dir != "NULL":
                dir_format = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]

            if type(dir_format) is dict:
                a[i] = Image.open(dir_format[i + 1])
            else:
                a[i] = Image.open(dir_format)
        
            a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)
        
            b[i] = ImageTk.PhotoImage(a[i])
            if is_manhwa:
                Label(second_frame, image=b[i]).grid(row=i, column=0, sticky="nsew")
            else:
                Label(second_frame, image=b[i]).grid(row=0, column=i, sticky="nsew")



    def show_button(event):
        def up():
            xory(400)
    
        def down():
            xory(-400)
    
        def go_next():
            global chap_num
            root.destroy()
            chap_num = chap_num + 1
            mainthing()
    
        def go_previous():
            global chap_num
            root.destroy()
            chap_num = chap_num - 1
            mainthing()
    
    
        global on, is_auto, button, button2, button3, button4, button5,i
        if on == 1:
            if is_manhwa:
                my_canvas.pack(side=LEFT ,fill=BOTH, expand=1)
            else:
                my_canvas.pack(side=TOP ,fill=BOTH, expand=1)

            button = Button(root, text='>>', command=go_next)
            button2 = Button(root, text='<<', command=go_previous)
            if is_manhwa:
                button3 = Button(root, text='>', command=up)
            else:
                print(i)
                if i >= filesindir_length : button4 = Button(root, text='<', command=somefunc())
    
            if is_manhwa:
                button4 = Button(root, text='<', command=down)
            else:
                if i <= filesindir_length : button4 = Button(root, text='<', command=somefunc(False))
    
            button.pack(side=RIGHT, fill=BOTH, expand=True)
            button2.pack(side=LEFT, fill=BOTH, expand=True)
            button3.pack(side=RIGHT, fill=BOTH, expand=True)
            button4.pack(side=LEFT, fill=BOTH, expand=True)
            on = 0
        else:
            button.pack_forget()
            button2.pack_forget()
            button3.pack_forget()
            button4.pack_forget()
            on = 1
    


    root.bind("<Button-3>" , show_button)
    root.mainloop()

mainthing()
