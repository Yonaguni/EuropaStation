/proc/is_safe_atmosphere(datum/gas_mixture/atmosphere, var/returntext = 0)
    var/list/status = list()
    if(!atmosphere)
        status.Add("No atmosphere present.")

    // Temperature check
    if((atmosphere.temperature > (T0C + 50)) || (atmosphere.temperature < (T0C - 10)))
        status.Add("Temperature too [atmosphere.temperature > (T0C + 50) ? "high" : "low"].")

    // Pressure check
    var/pressure = atmosphere.return_pressure()
    if((pressure > 120) || (pressure < 80))
        status.Add("Pressure too [pressure > 120 ? "high" : "low"].")

    // Gas concentration checks
    var/oxygen = 0
    var/fuel = 0
    var/carbondioxide = 0
    var/nitrousoxide = 0
    if(atmosphere.total_moles) // Division by zero prevention
        oxygen = (atmosphere.gas[REAGENT_ID_OXYGEN] / atmosphere.total_moles) * 100 // Percentage of the gas
        fuel = (atmosphere.gas[REAGENT_ID_FUEL] / atmosphere.total_moles) * 100
        carbondioxide = (atmosphere.gas[REAGENT_ID_CARBONDIOXIDE] / atmosphere.total_moles) * 100
        nitrousoxide = (atmosphere.gas[REAGENT_ID_N2O] / atmosphere.total_moles) * 100

    if(!oxygen)
        status.Add("No oxygen.")
    else if((oxygen > 30) || (oxygen < 17))
        status.Add("Oxygen too [oxygen > 30 ? "high" : "low"].")

    if(fuel > 0.1)        // Toxic even in small amounts.
        status.Add("Fuel contamination.")
    if(nitrousoxide > 0.1)    // Probably slightly less dangerous but still.
        status.Add("N2O contamination.")
    if(carbondioxide > 5)    // Not as dangerous until very large amount is present.
        status.Add("CO2 concentration high.")

    if(returntext)
        return jointext(status, " ")
    else
        return status.len