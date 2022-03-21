import net
import time
import os
import term

const (
	red = "\033[31m"
	white = "\033[37m"
	colors = ["[38;2;255;0;255m", "[38;2;224;30;254m", "[38;2;193;60;253m", "[38;2;162;90;252m", "[38;2;131;120;251m", "[38;2;100;150;250m", "[38;2;69;180;249m", "[38;2;38;210;248m", "[38;2;69;180;249m", "[38;2;100;150;250m", "[38;2;131;120;251m", "[38;2;162;90;252m", "[38;2;193;60;253m", "[38;2;224;30;254m"]
)

fn main() {
	ip := os.args[1] or {
		eprintln("Invalid args! | ./ping <ip> <port> <amount>")
		return
	}
	port := os.args[2] or {
		eprintln("Invalid args! | ./ping <ip> <port> <amount>")
		return
	}
	requests := os.args[3] or {
		eprintln("Invalid args! | ./ping <ip> <port> <amount>")
		return
	}
	mut counter := 0
	mut failed := 0
	term.clear()
	print("${white}Probing ${ip} On Port ${port} With ${requests} Requests\n\n")
	for {
		for color in colors {
			counter += 1
			net.dial_tcp("${ip}:${port}") or {
			eprintln("${red}Connection Timed Out On ${ip}:${port}${white}")
				time.sleep(1 * time.second)
				failed += 1
				continue
			}
			print("${white}[${color}Connected To ${white}${ip}${color} On Port ${white}${port} ${color}Protocol ${white}TCP ${color}Count ${white}${counter}${color} Online${white}]\n")
			time.sleep(1 * time.second)
			if counter == requests.int() {
				print("Stopping test | ${counter} requests sent, ${failed} failed to connect!\n")
				return
			}
		}
	}
}
