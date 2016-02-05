/proc/sanitize_frequency(var/f, var/low = PUBLIC_LOW_FREQ, var/high = PUBLIC_HIGH_FREQ)
	f = round(f)
	f = max(low, f)
	f = min(high, f)
	if ((f % 2) == 0) //Ensure the last digit is an odd number
		f += 1
	return f