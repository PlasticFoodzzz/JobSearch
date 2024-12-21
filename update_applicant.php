<?php
include 'include/db_connection.php'; // Adjust the path as necessary

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $applicant_id = $_POST['APPLICANTID'];
    $fname = mysqli_real_escape_string($conn, $_POST['FNAME']);
    $lname = mysqli_real_escape_string($conn, $_POST['LNAME']);
    $address = mysqli_real_escape_string($conn, $_POST['ADDRESS']);
    $email = mysqli_real_escape_string($conn, $_POST['EMAILADDRESS']);
    $contact = mysqli_real_escape_string($conn, $_POST['CONTACTNO']);
    $degree = mysqli_real_escape_string($conn, $_POST['DEGREE']);

    // Update query
    $query = "UPDATE tblapplicants SET 
              FNAME = '$fname', 
              LNAME = '$lname', 
              ADDRESS = '$address', 
              EMAILADDRESS = '$email', 
              CONTACTNO = '$contact', 
              DEGREE = '$degree'
              WHERE APPLICANTID = $applicant_id";

    if (mysqli_query($conn, $query)) {
        echo "Applicant updated successfully.";
        header("Location: applicationform.php"); // Redirect to applicants list
    } else {
        echo "Error updating applicant: " . mysqli_error($conn);
    }
}
?>
