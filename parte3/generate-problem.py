#!/usr/bin/env python3

########################################################################################
# Problem instance generator skeleton for emergencies drones domain.
# Based on the Linköping University TDDD48 2021 course.
# https://www.ida.liu.se/~TDDD48/labs/2021/lab1/index.en.shtml
#
# You mainly have to change the parts marked as TODO.
#
########################################################################################


from optparse import OptionParser
import random
import math
import sys

########################################################################################
# Hard-coded options
########################################################################################

# boxes will have different contents, such as food and meds.
# You can change this to generate other contents if you want.

content_types = ["comida", "medicina"]


########################################################################################
# Random seed
########################################################################################

# Set seed to 0 if you want more predictability...
# random.seed(0);

########################################################################################
# Helper functions
########################################################################################

# We associate each location with x/y coordinates.  These coordinates
# won't actually be used explicitly in the domain, but we *will*
# eventually use them implicitly by using *distances* in order to
# calculate flight times.
#
# This function returns the euclidean distance between two locations.
# The locations are given via their integer index.  You won't have to
# use this other than indirectly through the flight cost function.
def distance(location_coords, location_num1, location_num2):
    x1 = location_coords[location_num1][0]
    y1 = location_coords[location_num1][1]
    x2 = location_coords[location_num2][0]
    y2 = location_coords[location_num2][1]
    return math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2)


# This function returns the action cost of flying between two
# locations supplied by their integer indexes.  You can use this
# function when you extend the problem generator to generate action
# costs.
def flight_cost(location_coords, location_num1, location_num2):
    return int(distance(location_coords, location_num1, location_num2)) + 1


# When you run this script you specify the *total* number of boxes
# you want.  The function below determines randomly which boxes
# will have a specific type of contents.  boxes_with_contents[0]
# is a list of boxes containing content_types[0] (in our
# example "food"), and so on.
# Note: Will have at least one box per type!

def setup_content_types(options):
    while True:
        num_boxes_with_contents = []
        boxes_left = options.boxes
        for x in range(len(content_types) - 1):
            types_after_this = len(content_types) - x - 1
            max_now = boxes_left - types_after_this
            # print x, types_after_this, boxes_left, len(content_types), max_now
            num = random.randint(1, max_now)
            # print num
            num_boxes_with_contents.append(num)
            boxes_left -= num
        num_boxes_with_contents.append(boxes_left)
        # print(num_boxes_with_contents)

        # If we have 10 meds and 4 food, with 7 people,
        # we can support at most 7+4=11 goals.
        maxgoals = sum(min(num_boxes, options.humans) for num_boxes in num_boxes_with_contents)

        # Check if the randomization supports the number of goals we want to generate.
        # Otherwise, try to randomize again.
        if options.goals <= maxgoals:
            # Done
            break

    print()
    print("Types\tQuantities")
    for x in range(len(num_boxes_with_contents)):
        if num_boxes_with_contents[x] > 0:
            print(content_types[x] + "\t " + str(num_boxes_with_contents[x]))

    boxes_with_contents = []
    counter = 1
    for x in range(len(content_types)):
        boxes = []
        for y in range(num_boxes_with_contents[x]):
            boxes.append("box" + str(counter))
            counter += 1
        boxes_with_contents.append(boxes)

    return boxes_with_contents


# This function populates the location_coords list with an X and Y
# coordinate for each location.  You won't have to use this other than
# indirectly through the flight cost function.
def setup_location_coords(options):
    location_coords = [(0, 0)]  # For the warehouse
    for x in range(1, options.locations + 1):
        location_coords.append((random.randint(1, 200), random.randint(1, 200)))

    print("Location positions", location_coords)
    return location_coords


# This function generates a random set of goals.
# After you run this, need[humanid][contentid] is true if and only if
# the goal is for the human to have a box with the specified content.
# You will use this to create goal statements in PDDL.
def setup_human_needs(options, boxes_with_contents):
    need = [[False for i in range(len(content_types))] for j in range(options.humans)]
    goals_per_contents = [0 for i in range(len(content_types))]

    for goalnum in range(options.goals):

        generated = False
        while not generated:
            rand_human = random.randint(0, options.humans - 1)
            rand_content = random.randint(0, len(content_types) - 1)
            # If we have enough boxes with that content
            # and the human doesn't already need that content
            if (goals_per_contents[rand_content] < len(boxes_with_contents[rand_content])
                    and not need[rand_human][rand_content]):
                need[rand_human][rand_content] = True
                goals_per_contents[rand_content] += 1
                generated = True
    return need


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
                      help='the number of locations apart from the warehouse ')
    parser.add_option('-p', '--humans', metavar='NUM', type=int, dest='humans', help='the number of humans')
    parser.add_option('-c', '--boxes', metavar='NUM', type=int, dest='boxes', help='the number of boxes available')
    parser.add_option('-g', '--goals', metavar='NUM', type=int, dest='goals',
                      help='the number of boxes assigned in the goal')

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

    if options.humans is None:
        print("You must specify --humans (use --help for help)")
        sys.exit(1)

    if options.boxes is None:
        print("You must specify --boxes (use --help for help)")
        sys.exit(1)

    if options.goals is None:
        print("You must specify --goals (use --help for help)")
        sys.exit(1)

    if options.goals > options.boxes:
        print("Cannot have more goals than boxes")
        sys.exit(1)

    if len(content_types) > options.boxes:
        print("Cannot have more content types than boxes:", content_types)
        sys.exit(1)

    if options.goals > len(content_types) * options.humans:
        print("For", options.humans, "humans, you can have at most", len(content_types) * options.humans, "goals")
        sys.exit(1)

    print("Drones\t\t", options.drones)
    print("Carriers\t", options.carriers)
    print("Locations\t", options.locations)
    print("humans\t\t", options.humans)
    print("boxes\t\t", options.boxes)
    print("Goals\t\t", options.goals)

    # Setup all lists of objects

    # These lists contain the names of all Drones, locations, and so on.

    drone = []
    human = []
    box = []
    carrier = []
    location = []

    location.append("deposito")
    for x in range(options.locations):
        location.append("l" + str(x + 1))
    for x in range(options.drones):
        drone.append("dron" + str(x + 1))
    for x in range(options.carriers):
        carrier.append("transportador" + str(x + 1))
    for x in range(options.humans):
        human.append("p" + str(x + 1))
    for x in range(options.boxes):
        box.append("c" + str(x + 1))
    
    # Determine the set of boxes for each content.
    # If content_types[0] is "food",
    # then boxes_with_contents[0] is a list
    # containing the names of all boxes that contain food.
    boxes_with_contents = setup_content_types(options)

    # Generates coordinates for each location.
    # You will only use this indirectly,
    # through the flight_cost() function in lab 2.
    location_coords = setup_location_coords(options)

    # Determine which types of content each human needs.
    # If human[0] is "human0",
    # and content_types[1] is "meds",
    # then needs[0][1] is true iff human0 needs meds.
    need = setup_human_needs(options, boxes_with_contents)

    # Define a problem name
    problem_name1 = "drone_problem_d" + str(options.drones) + "_r" + str(options.carriers) + \
                   "_l" + str(options.locations) + "_p" + str(options.humans) + "_c" + str(options.boxes) + \
                   "_g" + str(options.goals) + "_ct" + str(len(content_types))

    problem_name = "problema_" + str(options.locations)

    # Open output file
    with open(problem_name + ".pddl", 'w') as f:
        # Write the initial part of the problem

        f.write("(define (problem " + problem_name + ")\n")
        f.write("(:domain drone-dom)\n")
        f.write("(:objects\n")

        ######################################################################
        # Write objects

        # TODO: Change the type names below (drone, location, ...)
        # to suit your domain.

        for x in drone:
            f.write("\t" + x + " - dron\n")

        for x in location:
            f.write("\t" + x + " - location\n")

        for x in box:
            f.write("\t" + x + " - caja\n")

        for x in content_types:
            f.write("\t" + x + " - contenido\n")

        for x in human:
            f.write("\t" + x + " - persona\n")

        for x in carrier:
            f.write("\t" + x + " - transportador\n")
        
        f.write("\t" + 'n0 n1 n2 n3 n4' + " - num\n")

        f.write(")\n")

        ######################################################################
        # Generate an initial state

        f.write("(:init\n")

        # TODO: Initialize all facts here!
        for d in drone:
            f.write("\t(esta-dron " + d + " " + location[0] + ")\n")
            f.write("\t(libre-dron " + d + ")\n")
        for b in box:
            f.write("\t(esta-caja " + b + " " + location[0] + ")\n")
            f.write("\t(almacena "+ b + " " + random.choice(content_types)+")\n")
        for c in carrier:
            f.write("\t(esta-trans " + c + " " + location[0] + ")\n")
            f.write("\t(trans-carga " + c + " n0)\n")
        for h in human:
            f.write("\t(esta-persona "+ h + " " + random.choice(location[1:])+")\n")

        f.write('\t(siguiente n0 n1)\n')
        f.write('\t(siguiente n1 n2)\n')
        f.write('\t(siguiente n2 n3)\n')
        f.write('\t(siguiente n3 n4)\n')

        for i in range(len(location)):
            for j in range(len(location)):
                if (i == j):
                    f.write("\t(= (fly-cost " + location[i] + " " + location[j] + ") 0)\n")
                else:
                    rand = random.randint(1, 50)
                    f.write("\t(= (fly-cost " + location[i] + " " + location[j] + ") " + str(rand) + ")\n")

        f.write(")\n\n")

        ######################################################################
        # Write Goals

        f.write("(:goal (and\n")

        # All Drones should end up at the warehouse
        for x in drone:
            # TODO: Write a goal that the drone x is at the warehouse
            f.write("\t(esta-dron " + x + " " + location[0] + ")\n")

        for x in range(options.humans):
            for y in range(len(content_types)):
                if need[x][y]:
                    human_name = human[x]
                    content_name = content_types[y]
                    # TODO: write a goal that the human needs a box
                    # with this specific content
                    f.write("\t(consigue " + human_name + " " + content_name + ")\n")

        f.write("\t))\n")
        
        f.write(")\n")


if __name__ == '__main__':
    main()