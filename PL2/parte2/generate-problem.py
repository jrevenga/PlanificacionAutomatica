from optparse import OptionParser
import random
import math
import sys

########################################################################################
# Main program
########################################################################################

def main():
    # Take in all arguments and print them to standard output

    parser = OptionParser(usage='python generator.py [-help] options...')
    parser.add_option('-d', '--drones', metavar='NUM', dest='drones', action='store', type=int, help='the number of drones')
    parser.add_option('-r', '--carriers', metavar='NUM', type=int, dest='carriers',
                      help='the number of carriers, for later labs; use 0 for no carriers')
    parser.add_option('-l', '--locations', metavar='NUM', type=int, dest='locations',
                      help='the number of locations apart from the depot ')

    (options, args) = parser.parse_args()

    if options.drones is None:
        print("You must specify --drones (use --help for help)")
        sys.exit(1)

    if options.carriers is None:
        print("You must specify --carriers (use --help for help)")
        sys.exit(1)

    if options.locations is None:
        print("You must specify --locations (use --help for help)")
        sys.exit(1)

    print("Drones\t\t", options.drones)
    print("Carriers\t", options.carriers)
    print("Locations\t", options.locations)

    # Setup all lists of objects

    # These lists contain the names of all Drones, locations, and so on.

    drone = []
    carrier = []
    location = []

    location.append("deposito")
    for x in range(options.locations):
        location.append("l" + str(x + 1))
    for x in range(options.drones):
        drone.append("dron" + str(x + 1))
    for x in range(options.carriers):
        carrier.append("trans" + str(x + 1))

    
    problem_name = "problema_" + str(options.locations)

    # Open output file
    with open(problem_name, 'w') as f:
        # Write the initial part of the problem

        f.write("(defproblem problem dron\n\n")
        f.write("\t(\n")

        ######################################################################
        # Write objects
        f.write("\t")
        for x in drone:
            f.write("(DRON " + x + ") ")
        f.write("\n\t")    
        for x in location:
            f.write("(LOCATION " + x + ") ")
        f.write("\n\t") 
        for x in carrier:
            f.write("(TRANSPORTADOR " + x + ") ")
        f.write("\n\t") 
        for x in carrier:
            cap = input("Introduce la capacidad del transportador "+x+": ")
            f.write("(CAPACIDAD " + x + " "+cap+") ")
        
        f.write("\n\t(COSTE cost)\n")
        

        ######################################################################
        # Generate an initial state

        # TODO: Initialize all facts here!

        f.write("\t(travel-cost cost 0)\n")
        for d in drone:
            f.write("\t(esta-dron "+ d + " deposito)\n")
            f.write("\t(libre "+ d + ")\n")
        for c in carrier:
            f.write("\t(esta-trans "+ c + " deposito)\n")
        for l in location[1:]:
            cajas = input("Introduce el numero de cajas que hay en la localizacion "+l+ ": ")
            f.write("\t(necesita "+ l + " "+cajas+")\n")

        f.write("\t)\n\n")

        ######################################################################
        # Write Goals

        f.write("\t(\n")

        f.write("\t(enviar-todo)\n")

        f.write("\t)\n")
        f.write(")\n")


if __name__ == '__main__':
    main()