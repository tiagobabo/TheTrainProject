# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Users
user1 = User.create(name: "Tiago Babo", username: "tiagobabo", password: "123456")
user2 = User.create(name: "Hélder Moreira", username: "heldermoreira", password: "123456")

# Cards
Card.create(number: "123456789", card_type: "Visa", user_id: user1.id, validity: "1-1-2013")
Card.create(number: "987654321", card_type: "MasterCard", user_id: user2.id, validity: "2-1-2013")

# Stops
s1 = Stop.create(location: "Ermesinde")
s2 = Stop.create(location: "Suzão")
s3 = Stop.create(location: "Valongo")
s4 = Stop.create(location: "Águas Santas")
s5 = Stop.create(location: "Rio Tinto")
s6 = Stop.create(location: "Travagem")
s7 = Stop.create(location: "Leandro")
s8 = Stop.create(location: "Cête")
s9 = Stop.create(location: "Penafiel")

# Distance
Distance.create(stop1_id: s3.id, stop2_id: s2.id, distance: 4)
Distance.create(stop1_id: s2.id, stop2_id: s1.id, distance: 5)
Distance.create(stop1_id: s1.id, stop2_id: s4.id, distance: 6)
Distance.create(stop1_id: s4.id, stop2_id: s5.id, distance: 3)

Distance.create(stop1_id: s7.id, stop2_id: s6.id, distance: 5)
Distance.create(stop1_id: s6.id, stop2_id: s1.id, distance: 3)
Distance.create(stop1_id: s1.id, stop2_id: s8.id, distance: 7)
Distance.create(stop1_id: s8.id, stop2_id: s9.id, distance: 5)

# Routes
r1 = Route.create(starts: "9:00", ends: "12:00")
r12 = Route.create(starts: "13:00", ends: "16:00")
r13 = Route.create(starts: "17:00", ends: "20:00")

r2 = Route.create(starts: "9:00", ends: "12:00")
r22 = Route.create(starts: "13:00", ends: "16:00")
r23 = Route.create(starts: "17:00", ends: "20:00")

r3 = Route.create(starts: "9:00", ends: "12:30")
r32 = Route.create(starts: "13:30", ends: "17:00")
r33 = Route.create(starts: "18:00", ends: "21:30")

r4 = Route.create(starts: "9:00", ends: "12:30")
r42 = Route.create(starts: "13:30", ends: "17:00")
r43 = Route.create(starts: "18:00", ends: "21:30")

# RoutesStops
RouteStop.create(route_id: r1.id, stop_id: s3.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r1.id, stop_id: s2.id, stop_order: 2, delay: 40)
RouteStop.create(route_id: r1.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r1.id, stop_id: s4.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r1.id, stop_id: s5.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r12.id, stop_id: s3.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r12.id, stop_id: s2.id, stop_order: 2, delay: 40)
RouteStop.create(route_id: r12.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r12.id, stop_id: s4.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r12.id, stop_id: s5.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r13.id, stop_id: s3.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r13.id, stop_id: s2.id, stop_order: 2, delay: 40)
RouteStop.create(route_id: r13.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r13.id, stop_id: s4.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r13.id, stop_id: s5.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r2.id, stop_id: s5.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r2.id, stop_id: s4.id, stop_order: 2, delay: 30)
RouteStop.create(route_id: r2.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r2.id, stop_id: s2.id, stop_order: 4, delay: 140)
RouteStop.create(route_id: r2.id, stop_id: s3.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r22.id, stop_id: s5.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r22.id, stop_id: s4.id, stop_order: 2, delay: 30)
RouteStop.create(route_id: r22.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r22.id, stop_id: s2.id, stop_order: 4, delay: 140)
RouteStop.create(route_id: r22.id, stop_id: s3.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r23.id, stop_id: s5.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r23.id, stop_id: s4.id, stop_order: 2, delay: 30)
RouteStop.create(route_id: r23.id, stop_id: s1.id, stop_order: 3, delay: 90)
RouteStop.create(route_id: r23.id, stop_id: s2.id, stop_order: 4, delay: 140)
RouteStop.create(route_id: r23.id, stop_id: s3.id, stop_order: 5, delay: 180)

RouteStop.create(route_id: r3.id, stop_id: s7.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r3.id, stop_id: s6.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r3.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r3.id, stop_id: s8.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r3.id, stop_id: s9.id, stop_order: 5, delay: 210)

RouteStop.create(route_id: r32.id, stop_id: s7.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r32.id, stop_id: s6.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r32.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r32.id, stop_id: s8.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r32.id, stop_id: s9.id, stop_order: 5, delay: 210)

RouteStop.create(route_id: r33.id, stop_id: s7.id, stop_order: 1, delay: 0)
RouteStop.create(route_id: r33.id, stop_id: s6.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r33.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r33.id, stop_id: s8.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r33.id, stop_id: s9.id, stop_order: 5, delay: 210)

RouteStop.create(route_id: r4.id, stop_id: s7.id, stop_order: 5, delay: 210)
RouteStop.create(route_id: r4.id, stop_id: s6.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r4.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r4.id, stop_id: s8.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r4.id, stop_id: s9.id, stop_order: 1, delay: 0)

RouteStop.create(route_id: r42.id, stop_id: s7.id, stop_order: 5, delay: 210)
RouteStop.create(route_id: r42.id, stop_id: s6.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r42.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r42.id, stop_id: s8.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r42.id, stop_id: s9.id, stop_order: 1, delay: 0)

RouteStop.create(route_id: r43.id, stop_id: s7.id, stop_order: 5, delay: 210)
RouteStop.create(route_id: r43.id, stop_id: s6.id, stop_order: 4, delay: 150)
RouteStop.create(route_id: r43.id, stop_id: s1.id, stop_order: 3, delay: 80)
RouteStop.create(route_id: r43.id, stop_id: s8.id, stop_order: 2, delay: 50)
RouteStop.create(route_id: r43.id, stop_id: s9.id, stop_order: 1, delay: 0)

# Price
Price.create(price: 0.25)








