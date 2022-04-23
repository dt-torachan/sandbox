public class Main {
	public static void main(String[] args) {
		Car truck = new Truck(); 

		System.out.println("トラックは最高速度"+truck.speed_max+"の"+truck.number_of_wheels+"輪車両です");

		Car passengercar = new PassengerCar(); 

		System.out.println("普通乗用車は最高速度"+passengercar.speed_max+"の"+passengercar.number_of_wheels+"輪車両です");
	}
}