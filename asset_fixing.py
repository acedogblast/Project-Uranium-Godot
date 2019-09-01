import os
import platform

def system(command):
    return os.system(command)

platform_name = platform.system()

delete_function=""
find_executable_function=""

expected_find_result=0
directory_seperator=""

if platform_name == "Windows":
    delete_function="DEL /F /Q "
    find_executable_function="where "
    expected_find_result=0
    directory_seperator="\\"
elif platform_name == "Linux":
    delete_function="rm -f "
    find_executable_function="which "
    expected_find_result=0
    directory_seperator="/"
elif platform_name == "Darwin":
    delete_function="rm -f"
    #need to add find
    #need to add find result
    directory_seperator="/"
    print("mac not supported- no find function or result defined")
    exit()
else:
    print("This is a tooooootally unsupported platform. Did you write it yourself or something?")
    exit()

def delete(filename):
    return system(delete_function+'"'+filename.replace("/",directory_seperator)+'"')

#Check for ffmpeg
if system(find_executable_function+"ffmpeg") != expected_find_result:
    print("ffmpeg not found. Please install it or add it to path.")
    exit()

#Delete some graphics- steps 1,2,3,4
delete("./Graphics/Transitions/RotatingPieces.png")
delete("./Graphics/Pictures/dialup.png")


#Decompress wav files- steps 5,6,7,8,9,10,11
system("ffmpeg -i ./Audio/SE/computerclose.WAV -c:a pcm_s16le ./Audio/SE/computerclosePCM.WAV")
system("ffmpeg -i ./Audio/SE/computeropen.WAV -c:a pcm_s16le ./Audio/SE/computeropenPCM.WAV")
#Delete orginals
delete("./Audio/SE/computerclose.WAV")
delete("./Audio/SE/computeropen.WAV")

#Fix some file by remuxing- steps 12,13,14,15
system("ffmpeg -i ./Audio/SE/PU-Grasswalk.ogg -c:a copy ./Audio/SE/PU-GrasswalkFixed.ogg")
#delete the original
delete("./Audio/SE/PU-Grasswalk.ogg")

#cropping and joining of the outside file
system('ffmpeg -i "./Graphics/Tilesets/Outside(new).png" -vf "crop=256:10528:0:0,pad=256:10728:0:0:0x000000@0x00" "./Graphics/Tilesets/OutsideTop.png"')
system('ffmpeg -i "./Graphics/Tilesets/Outside(new).png" -vf "crop=256:10728:0:10528" "./Graphics/Tilesets/OutsideBottom.png"')
system('ffmpeg -i "./Graphics/Tilesets/OutsideTop.png" -i "./Graphics/Tilesets/OutsideBottom.png" -filter_complex hstack,crop=512:10569:0:0 "./Graphics/Tilesets/OutsideFixed.png"')
#remove the original file
delete("./Graphics/Tilesets/Outside(new).png")
