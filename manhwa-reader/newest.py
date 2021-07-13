from tkinter import *
from tkinter import ttk
from PIL import ImageTk,Image
from itertools import chain
from os import *
import os
import sys

is_manhwa = True

direct_photo = False
increment = 0
i = 0
x = 0
scroll_mode = 0
chap_num = 0
height = 1000
width = 700
my_dir = "NULL"
in_dir = {}

for item in sys.argv:
    is_option = "-" in item
    is_dir = "/" in item
    is_py = ".py" in item
    is_photo = ".j" in item or ".pn" in item or ".w" in item
    is_number = type(item)

    if is_option == False and is_dir == False and is_py == False:
        chap_num = item 
        chap_num = int(chap_num)
        chap_num = chap_num - 1

    if is_option == True and is_py == False and is_dir == False:
        if item == "-s" : scroll_mode = 1
        if item == "-n" : is_manhwa = False

    if is_option == False and os.path.isdir(item) == False and is_py == False and is_photo == True:
        my_dir = "NULL"
        direct_photo = True

        increment2 = increment - 1
            
        in_dir[increment2] = item

    if is_option == False and is_py == False and os.path.isdir(item) == True:

        my_names = {}
        my_ext = {}

        files = listdir(item)
        files.sort()
        for child in files:
            if os.path.isdir(item + "/" + child):
                my_dir = item
            else:
                name, ext = os.path.splitext(child)
                my_names[increment] = str(name)
                my_ext[increment] = str(ext)
                increment = increment + 1

                my_dir = "NULL"
                maindir = item

        if os.path.isdir(item + "/" + child) == False:
            my_names = sorted(my_names)
            mylist = []

            mylist.append(str(my_names[0]) + my_ext[1])
            for x in range(1,len(my_names),1):
                mylist.append(str(my_names[x]) + my_ext[x])

            in_dir = mylist

    increment = increment + 1

def change_mode(event):
    global is_manhwa, root
    root.destroy()
    if is_manhwa:
        is_manhwa = False
    else:
        is_manhwa = True
    mainthing()

def change_mode_button():
    global is_manhwa, root, button_name
    root.destroy()
    if is_manhwa:
        is_manhwa = False
    else:
        is_manhwa = True
    mainthing()

def xory(speed = 10):
    if is_manhwa:
        my_canvas.yview_scroll(speed, "units")
    #else:
    #    my_canvas.xview_scroll(speed, "units")

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
    global on, my_canvas, root, my_scrollbar, my_dir, filesindir, filesindir_length, maindir
    root = Tk()

    root.title('Manhwa Reader')
    root.configure(background='black')
    root.geometry('700x1000')
    root.resizable(False, False)
    root.bind("<Button-5>" , mousewheel_up)
    root.bind("j" , mousewheel_up)
    root.bind("<Button-4>" , mousewheel_down)
    root.bind("k" , mousewheel_down)
    root.bind("q" , on_exit)
    root.bind("c" , change_mode)
    on = 1

    main_frame = Frame(root)
    main_frame.pack(fill=BOTH, expand=1)

    my_canvas = Canvas(main_frame, yscrollincrement=2)

    if scroll_mode == 1:

            my_canvas.pack(side=LEFT ,fill=BOTH, expand=1)
            my_scrollbar = Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
            my_scrollbar.pack(side=RIGHT, fill=Y)

    else:
        my_canvas.pack(fill=BOTH, expand=1)
        if is_manhwa:
             my_scrollbar = Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
        else:
             my_scrollbar = Scrollbar(main_frame, orient=HORIZONTAL, command=my_canvas.xview)

    if is_manhwa:
        my_canvas.configure(yscrollcommand=my_scrollbar.set)
    else:
        my_canvas.configure(xscrollcommand=my_scrollbar.set)

    my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion = my_canvas.bbox("all")))
    
    second_frame = Frame(my_canvas)
    my_canvas.create_window((0,0), window=second_frame, anchor="nw")

    mypath = my_dir

    if my_dir == "NULL":
        in_dir_length = len(in_dir)
        filesindir = in_dir
        filesindir = sorted(filesindir)
        filesindir_length = in_dir_length

        dir_format = {}
        if direct_photo == False :
            for i in range(0, in_dir_length, 1):
                dir_format[i] = maindir + "/" + in_dir[i]
        else:
            for i in range(0, in_dir_length, 1):
                dir_format[i] = in_dir[i]

    else:
        maindir = listdir(mypath)
        maindir.sort()
        filesindir = listdir(my_dir + "/" + str(maindir[chap_num]))
        filesindir.sort()
        filesindir_length = len(filesindir)
        dir_format = {}

    a = {}
    b = {}
    if is_manhwa == False:
        def somefunc2():
            global i

            if is_manhwa:
                if i != (len(filesindir) - 1):
                    i = i + 1
            else:
                if i != (len(in_dir) - 1):
                    i = i + 1

            if is_manhwa:
                dir_format[i] = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]
            else:
                if direct_photo == False :
                    if type(maindir) is list:
                        dir_format[i] = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]
                    else:
                        dir_format[i] = maindir + "/" + in_dir[i]
                else:
                    dir_format[i] = in_dir[i]


            if type(dir_format) is dict:
                  a[i] = Image.open(dir_format[i])
            else:
                  a[i] = Image.open(dir_format)

            a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)

            b[i] = ImageTk.PhotoImage(a[i])
            label = Label(second_frame, image=b[i]).grid(row=0, column=0, sticky="nsew")

        def somefunc():
            global i
            if i != 0:
                i = i - 1

            if is_manhwa:
                dir_format[i] = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]
            else:
                if direct_photo == False :
                    if type(maindir) is list:
                        dir_format[i] = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]
                    else:
                        dir_format[i] = maindir + "/" + in_dir[i]
                else:
                    dir_format[i] = in_dir[i]

            if type(dir_format) is dict:
                a[i] = Image.open(dir_format[i])
            else:
                a[i] = Image.open(dir_format)
            
            a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)
            
            b[i] = ImageTk.PhotoImage(a[i])
            image = Label(second_frame, image=b[i]).grid(row=0, column=0, sticky="nsew")

        somefunc()
        
    else:

        for i in range(0, filesindir_length, 1):
        
            if my_dir != "NULL":
                dir_format[i] = my_dir + "/" + str(maindir[chap_num]) + "/" + filesindir[i]
            
            if type(dir_format) is dict:
                a[i] = Image.open(dir_format[i])
            else:
                a[i] = Image.open(dir_format)
            
            a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)
        
            b[i] = ImageTk.PhotoImage(a[i])
            Label(second_frame, image=b[i]).grid(row=i, column=0, sticky="nsew")

    def show_button(event):
        def up():
            xory(400)
    
        def down():
            xory(-400)
    
        def jump_up():
            xory(-90000000)

        def jump_down():
            xory(90000000)

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
    
    
        global on, is_auto, button, button2, button3, button4, button5, button6, button7, current_page, i, label1
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
                button3 = Button(root, text='>', command=somefunc2)
    
            if is_manhwa:
                button4 = Button(root, text='<', command=down)
            else:
                button4 = Button(root, text='<', command=somefunc)

            button_name = 'Mode: manhwa' if is_manhwa else 'Mode: manga'

            button5 = Button(root, text=button_name, command=change_mode_button)
            
            if is_manhwa: 
                button6 = Button(root, text='↑', command=jump_up)
                button7 = Button(root, text='↓', command=jump_down)

            if is_manhwa:
                current_page = str(len(filesindir)) + " Loaded"
            else:
                if len(in_dir) != 0:
                    current_page = str((i + 1)) + "/" + str(len(in_dir))
                else:
                    current_page = str((i + 1)) + "/" + str(filesindir_length)

            label1 = Label(root, text=current_page)
    
            button.pack(side=RIGHT, fill=BOTH, expand=True)
            button2.pack(side=LEFT, fill=BOTH, expand=True)
            button3.pack(side=RIGHT, fill=BOTH, expand=True)
            button4.pack(side=LEFT, fill=BOTH, expand=True)
            button5.pack(side=RIGHT, fill=BOTH, expand=True)
            if is_manhwa: 
                button6.pack(side=TOP, fill=BOTH)
                button7.pack(side=BOTTOM, fill=BOTH)

            label1.pack(side=LEFT, fill=BOTH, expand=True)
            on = 0
        else:
            button.pack_forget()
            button2.pack_forget()
            button3.pack_forget()
            button4.pack_forget()
            button5.pack_forget()
            if is_manhwa: 
                button6.pack_forget()
                button7.pack_forget()

            label1.pack_forget()
            on = 1
    
    if is_manhwa == False:
        def forget_scrollbar():
            global my_scrollbar
            my_scrollbar.pack_forget()

        def move(e):
            global i
            i = i + 1
            a[i] = Image.open(dir_format[i])
            b[i] = ImageTk.PhotoImage(a[i])
            label = Label(second_frame, image=b[i]).grid(row=0, column=0, sticky="nsew")

        def zoomIn(e):
            global i, width, height, my_scrollbar, x

            my_scrollbar.pack_forget()

            my_scrollbar = Scrollbar(main_frame, orient=HORIZONTAL, command=my_canvas.xview)
            my_scrollbar2 = Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
            my_canvas.configure(xscrollcommand=my_scrollbar.set)
            my_canvas.configure(yscrollcommand=my_scrollbar2.set)
            my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion = my_canvas.bbox("all")))
            if x == 0:
                my_scrollbar2.pack(side=RIGHT, fill=Y)

            #my_scrollbar.pack(side=BOTTOM, fill=X)
            my_canvas.pack(side=LEFT, fill=BOTH, expand=1)

            i = i + 1
            width = width + 100
            height = height + 150
            if x == 2:
                my_scrollbar2.pack_forget()
                x = 0

            x = 2

            somefunc()

        def zoomOut(e):
            global i, width, height
            i = i + 1
            width = width - 100
            height = height - 150
            somefunc()

        def Left(e):
            my_canvas.xview_scroll(-10, "units")
        def Right(e):
            my_canvas.xview_scroll(10, "units")
        def Down(e):
            my_canvas.yview_scroll(1, "units")
        def Up(e):
            my_canvas.yview_scroll(-1, "units")

        root.bind("<Button-4>", zoomIn)
        root.bind("<Button-5>", zoomOut)
        root.bind("<Left>", Left)
        root.bind("<Right>", Right)
        root.bind("<Up>", Up)
        root.bind("<Down>", Down)
    root.bind("<Button-3>" , show_button)
    root.mainloop()

mainthing()
