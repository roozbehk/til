# Remap Keys when using RDP with Mac to connect to windows machine. 

https://www.autohotkey.com/
```
;Autohotkey script
;John Walker, 2010-11-25
;walkerj@gmail.com
;http://www.inertreactants.com
;Feel free to reuse, edit and redistribute
;Key remaps for Apple users using boot camp
;(with an Apple notebook or Keyboard)

;following section remaps alt-delete keys to mimic OSX
;command-delete deletes whole line
#BS::Send {LShift down}{Home}{LShift Up}{Del}

;alt-function-delete deletes next word
!Delete::Send {LShift down}{LCtrl down}{Right}{LShift Up}{Lctrl up}{Del}

;alt-delete deletes previous word
!BS::Send {LShift down}{LCtrl down}{Left}{LShift Up}{Lctrl up}{Del}

;following section mimics command-q and command-w
;behaviour to close windows
;note these had to be disabled below for the
;command to ctrl key remaps
#w::^F4
#q::!F4

;following section remaps alt-arrow and command-arrow
;keys to mimic OSX behaviour
#Up::Send {Lctrl down}{Home}{Lctrl up}
#Down::Send {Lctrl down}{End}{Lctrl up}
#Left::Send {Home}
#Right::Send {End}
!Up::Send {Home}
!Down::Send {End}
!Left::^Left
!Right::^Right

;following section remaps command key to control key
;affects all number and letter keys
;note that some keys, like winkey-l and winkey-d
;need to be remapped a differeny way
;otherwise autohotkey will not take over 
#a::^a
#b::^b
#c::^c
#d::^d 
#e::^e
;following won't remap using the normal method
#f::Send {LCtrl down}{f}{LCtrl up}
#g::^g
#h::^h
#i::^i
#j::^j
#k::^k
;#l::Send {LCtrl down}{l}{LCtrl up} ;disabled, I like winkey-L
#m::^m
#n::^n
#o::^o
#p::^p
;#q::^q ;disabled --remapped to alt-F4 instead
#r::^r
#s::^s
#t::^t
#u::^u
#v::^v
;#w::^w ;disabled --remapped to ctrl-F4 instead
#x::^x
#y::^y
#z::^z
#1::^1
#2::^2
#3::^3
#4::^4
#5::^5
#6::^6
#7::^7
#8::^8
#9::^9
#0::^0
```
