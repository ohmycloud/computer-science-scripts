module ThinkUtil

export Trip, ChargeTrip, DriveTrip

abstract type Trip end

struct ChargeTrip <: Trip
    start_time::String
    end_time::String
    trip_st::Int32
end


# 声明可变结构体
mutable struct DriveTrip <: Trip
    start_time::String
    end_time::String
    trip_st::Int32
end    

end