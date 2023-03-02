import json

type
  Day = object
    year: string
    month: string
    date: string
    yearweek: string
    yearday: string
    lunar_year: string
    lunar_month: string
    lunar_date: string
    lunar_yearday: string
    week: string
    weekend: string
    workday: string
    holiday: string
    holiday_or: string
    holiday_overtime: string
    holiday_today: string
    holiday_legal: string
    holiday_recess: string

let jsonFile = readFile("2023.json")
let jsonObj = parseJson(jsonFile)
for key, value in jsonObj:
  let daily = to(value, Day)
  for inner_key, inner_value in value:
    case inner_key
    of "year": echo inner_value
    of "month": echo inner_value
    of "date": echo inner_value
    of "yearweek": echo inner_value
    of "yearday": echo inner_value
    of "lunar_yearday": echo inner_value
    of "week": echo inner_value
    else: echo "-----"