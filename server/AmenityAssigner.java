import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AmenityAssigner {

    // JDBC connection parameters
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/your_database_name";
    private static final String JDBC_USERNAME = "your_username";
    private static final String JDBC_PASSWORD = "your_password";

    // SQL queries
    private static final String SELECT_ALL_ROOMS_QUERY = "SELECT * FROM Room";

    // Method to retrieve a list of all rooms
    public static List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(SELECT_ALL_ROOMS_QUERY)) {

            while (resultSet.next()) {
                // Retrieve room attributes from the ResultSet
                int roomNumber = resultSet.getInt("room_number");
                String hotelAddress = resultSet.getString("hotel_address");
                int capacity = resultSet.getInt("capacity");
                String view = resultSet.getString("view");
                double price = resultSet.getDouble("price");
                boolean extendability = resultSet.getBoolean("extendability");
                Date bookingStartDate = resultSet.getDate("booking_start_date");
                Date bookingEndDate = resultSet.getDate("booking_end_date");
                String roomStatus = resultSet.getString("room_status");

                // Create Room object and add it to the list
                Room room = new Room(roomNumber, hotelAddress, capacity, view, price, extendability,
                        bookingStartDate, bookingEndDate, roomStatus);
                rooms.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle any SQL exceptions
        }

        return rooms;
    }

    // Sample Room class (replace with your actual Room class)
    private static class Room {
        int roomNumber;
        String hotelAddress;
        int capacity;
        String view;
        double price;
        boolean extendability;
        Date bookingStartDate;
        Date bookingEndDate;
        String roomStatus;

        public Room(int roomNumber, String hotelAddress, int capacity, String view, double price, boolean extendability,
                    Date bookingStartDate, Date bookingEndDate, String roomStatus) {
            this.roomNumber = roomNumber;
            this.hotelAddress = hotelAddress;
            this.capacity = capacity;
            this.view = view;
            this.price = price;
            this.extendability = extendability;
            this.bookingStartDate = bookingStartDate;
            this.bookingEndDate = bookingEndDate;
            this.roomStatus = roomStatus;
        }
    }

    // Main method to test the retrieval of rooms
    public static void main(String[] args) {
        List<Room> rooms = getAllRooms();
        for (Room room : rooms) {
            System.out.println(room.roomNumber + ", " + room.hotelAddress + ", " + room.capacity + ", " +
                    room.view + ", " + room.price + ", " + room.extendability + ", " +
                    room.bookingStartDate + ", " + room.bookingEndDate + ", " + room.roomStatus);
        }
    }
}