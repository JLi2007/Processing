from tkinter import *
from math import *
from time import *
from random import *
root = Tk()
screen = Canvas(root, width=1000, height=600, background="black")

def setInitialValues():
    global xRocket, yRocket, ySpeed, flame, startMessage, deathMessage, randomInsults, gameRunning
    xRocket = 400
    yRocket = 100
    ySpeed = 0
    flame = 0
    deathMessage = 0
    randomInsults = ["dummy", "moron", "fool", "klutz", "dope", "noob", "goof ball",
                     "you lump of slime", "spaghettihead"]
    startMessage = screen.create_text(100,100,text="Click to fire the rocket's thruster", font = "Times 18",fill="red", anchor=W)
    gameRunning = True


def drawRocket():
    global rocketBase, rocketNose
    rocketBase = screen.create_rectangle( xRocket, yRocket, xRocket+50, yRocket+100, fill="blue", outline="blue" )
    rocketNose = screen.create_polygon( xRocket, yRocket, xRocket+25, yRocket-25, xRocket+50, yRocket, fill="yellow", outline="DodgerBlue" ) 


def mouseClickHandler( event ):
    global ySpeed, flame    
    if gameRunning == True:
        ySpeed = ySpeed - 5 
        flame = screen.create_polygon( xRocket, yRocket+100, xRocket+50, yRocket+100, xRocket+25, yRocket+210, fill="red")



def mouseReleaseHandler( event ):
    global flame
    screen.delete(flame) 
    

def beratePlayer():
    global startMessage, deathMessage, gameRunning
    gameRunning = False    
    screen.delete(startMessage)    
    nextInsult = choice( randomInsults )
    deathMessage = screen.create_text( 200, 400,
                                       text="You crashed the ship. Try again, " + nextInsult + ".",
                                       font = "Times 24", anchor=W, fill="red" )
    screen.update()
    sleep(2)
    screen.delete(deathMessage)


def updateObjects():
    global yRocket, ySpeed
    yRocket = yRocket + ySpeed  
    ySpeed = ySpeed + 0.6         

   
def runGame():  #Rungame is a recursive function.  That means it calls itself inside its own code
   #THIS RECURSIVE PROCEDURE HAS NO BASE CASE. THUS, IT RUNS FOREVER.
    global yRocket, ySpeed, flame, startMessage
       
    setInitialValues()

    #Keeps the game running for as long as the rocket's y-level stays below 600 (i.e. hasn't crashed)
    while yRocket < 600: 
        updateObjects()
        drawRocket()
        
        screen.update()
        sleep(0.03)
        screen.delete( rocketBase, rocketNose, flame )

    beratePlayer()

    runGame() #This is a "recursive call" (a function that calls itself)



root.after( 500, runGame)
screen.bind("<Button-1>", mouseClickHandler) 
screen.bind("<ButtonRelease-1>", mouseReleaseHandler) 
screen.pack()
screen.focus_set()
root.mainloop()
