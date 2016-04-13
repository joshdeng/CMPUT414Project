import math

# read bvh file and return the data as string
def readFile(name):
    endofprogram=False
    try:
        filename= name
        infile=open(filename,"r")
    except IOError:
        print("Error reading file. End of program")
        endofprogram=True
    if endofprogram==False:
        rawData=[]
        for line in infile:
            line=line.strip("\n")
            rawData.append(line)
        infile.close()
    return rawData

# parse the data into float
def parseData(rawData):
    motionData=[]
    for i in range(len(rawData)):
        if "MOTION" in rawData[i]:
            titleIndex = i
            break
    startIndex = titleIndex+4
    motionData = rawData[startIndex:len(rawData)]

    for i in range(len(motionData)):
        motionData[i] = motionData[i].split()
        for j in range(len(motionData[i])):
            motionData[i][j]=float(motionData[i][j])
    return motionData

# compare the error using the equation in report
def compare(motionA,motionB):
    err = 0
    frame = 0
    rawSum = 0
    if len(motionA)<len(motionB):
        frame = len(motionA)
    else:
        frame = len(motionB)

    for f in range(frame):
        currentFrameA = motionA[f]
        currentFrameB = motionB[f]
        assert(len(currentFrameA)==len(currentFrameB))
        for i in range(len(currentFrameA)):
            rawSum += (currentFrameA[i]-currentFrameB[i])*(currentFrameA[i]-currentFrameB[i])
        errj = math.sqrt(rawSum)
        err += errj

    return err/frame


def main():

    # read mutiple bvh file then compare them as pairs
    name1 = "staystill.bvh.txt"
    rawData1 = readFile(name1)
    motionData1 = parseData(rawData1)

    name2 = "staystill.bvh.txt"
    rawData2 = readFile(name2)
    motionData2 = parseData(rawData2)

    res = compare(motionData1,motionData2)
    print ("Error between two identical motions:", res)

    name1 = "wave_small.bvh.txt"
    rawData1 = readFile(name1)
    motionData1 = parseData(rawData1)

    name2 = "wave_small2.bvh.txt"
    rawData2 = readFile(name2)
    motionData2 = parseData(rawData2)

    res = compare(motionData1,motionData2)
    print ("Error between two waves record separately:", res)

    name1 = "wave_small.bvh.txt"
    rawData1 = readFile(name1)
    motionData1 = parseData(rawData1)

    name2 = "wave_big.bvh.txt"
    rawData2 = readFile(name2)
    motionData2 = parseData(rawData2)

    res = compare(motionData1,motionData2)
    print ("Error between small wave and big wave:", res)

    name1 = "wave_small.bvh.txt"
    rawData1 = readFile(name1)
    motionData1 = parseData(rawData1)

    name2 = "staystill.bvh.txt"
    rawData2 = readFile(name2)
    motionData2 = parseData(rawData2)

    res = compare(motionData1,motionData2)
    print ("Error between small wave and stay still", res)

    name1 = "staystill2.bvh.txt"
    rawData1 = readFile(name1)
    motionData1 = parseData(rawData1)

    name2 = "staystill.bvh.txt"
    rawData2 = readFile(name2)
    motionData2 = parseData(rawData2)

    res = compare(motionData1,motionData2)
    print ("Error between staystill1 and staystill2", res)

    

    

    


main()
    