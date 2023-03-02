include("ThinkUtil.jl")

import .ThinkUtil.ChargeTrip

charge_trip = ChargeTrip("start", "end", 10)
@show charge_trip

#LoadError: setfield! immutable struct of type ChargeTrip cannot be changed
# charge_trip.start_time = "开始"
# @show charge_trip

import .ThinkUtil.DriveTrip
drive_trip = DriveTrip("2021-10-28 14:32:00", "2021-10-28 15:12:45", 12)
@show drive_trip

drive_trip.end_time = "done"
@show drive_trip