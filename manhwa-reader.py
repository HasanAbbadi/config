from tkinter import *
from tkinter import ttk
from PIL import ImageTk,Image
from os import *
import sys

my_option = 0
chap_num = 0
my_dir = 0

for item in sys.argv:
    is_option = "-" in item
    is_dir = "/" in item
    is_py = ".py" in item
    is_number = type(item)

    if is_option == False and is_dir == False and is_py == False:
        chap_num = item 
        chap_num = int(chap_num)
        chap_num = chap_num - 1

    if is_option == True:
        my_option = 1
    if is_option == False and is_dir == True:
        mydir = item 


def mousewheel_up(event):
    my_canvas.yview_scroll(10, "units")

def mousewheel_down(event):
    my_canvas.yview_scroll(-10, "units")

def show_button(event):
    def up():
        my_canvas.yview_scroll(400, "units")

    def down():
        my_canvas.yview_scroll(-400, "units")

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

    global on, button, button2, button3, button4
    if on == 1:
        my_canvas.pack(side=LEFT ,fill=BOTH, expand=1)
        button = Button(root, text='>>', command=go_next)
        button2 = Button(root, text='<<', command=go_previous)
        button3 = Button(root, text='>', command=up)
        button4 = Button(root, text='<', command=down)
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

def on_exit(event):
    sys.exit()

    
if my_dir == 0:
    print("provide the directory")
    sys.exit()

def mainthing():
    global on, my_canvas, root, my_scrollbar
    root = Tk()
    root.title('Manhwa Reader')
    root.configure(background='black')
    root.geometry('700x1000')
    root.bind("<Button-5>" , mousewheel_up)
    root.bind("j" , mousewheel_up)
    root.bind("<Button-4>" , mousewheel_down)
    root.bind("k" , mousewheel_down)
    root.bind("q" , on_exit)
    
    main_frame = Frame(root)
    main_frame.pack(fill=BOTH, expand=1)
    
    my_canvas = Canvas(main_frame, yscrollincrement=2)
    
    on = 1
    root.bind("<Button-3>" , show_button)
    
    if my_option == 1:
            my_canvas.pack(side=LEFT ,fill=BOTH, expand=1)
            my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
            my_scrollbar.pack(side=RIGHT, fill=Y)
    else:
        my_canvas.pack(fill=BOTH, expand=1)
        my_scrollbar = ttk.Scrollbar(main_frame, orient=VERTICAL, command=my_canvas.yview)
    
    my_canvas.configure(yscrollcommand=my_scrollbar.set)
    my_canvas.bind('<Configure>', lambda e: my_canvas.configure(scrollregion = my_canvas.bbox("all")))
    
    second_frame = Frame(my_canvas)
    my_canvas.create_window((0,0), window=second_frame, anchor="nw")
    
    mypath = mydir
    maindir = listdir(mypath)
    maindir.sort()
    filesindir = listdir(mydir + "/" + str(maindir[chap_num]))
    filesindir.sort()
    
    filesindir_length = len(filesindir)
    
    a = {}
    b = {}
    for i in range(0, filesindir_length, 1):
        a[i] = Image.open(mydir + "/" + str(maindir[chap_num]) + "/" + filesindir[i])
        a[i] = a[i].resize((700, 1000), Image.ANTIALIAS)
    
        b[i] = ImageTk.PhotoImage(a[i])
        Label(second_frame, image=b[i]).grid(row=i, column=0, sticky="nsew")
    
    root.mainloop()

mainthing()
