<?php
include '../config.php'; // Include database connection

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    $query = "SELECT * FROM tblapplicants WHERE APPLICANTID = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $applicant = $result->fetch_assoc();
} else {
    echo "No applicant selected.";
    exit;
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $fname = $_POST['FNAME'];
    $lname = $_POST['LNAME'];
    $address = $_POST['ADDRESS'];
    $contact = $_POST['CONTACTNO'];
    $email = $_POST['EMAILADDRESS'];

    $updateQuery = "UPDATE tblapplicants SET FNAME = ?, LNAME = ?, ADDRESS = ?, CONTACTNO = ?, EMAILADDRESS = ? WHERE APPLICANTID = ?";
    $updateStmt = $conn->prepare($updateQuery);
    $updateStmt->bind_param("sssssi", $fname, $lname, $address, $contact, $email, $id);

    if ($updateStmt->execute()) {
        echo "Applicant details updated successfully.";
        header("Location: index.php");
        exit;
    } else {
        echo "Error updating applicant details.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Applicant</title>
</head>
<body>
    <h2>Edit Applicant</h2>
    <form method="POST">
        <label>First Name:</label>
        <input type="text" name="FNAME" value="<?php echo $applicant['FNAME']; ?>" required><br>
        <label>Last Name:</label>
        <input type="text" name="LNAME" value="<?php echo $applicant['LNAME']; ?>" required><br>
        <label>Address:</label>
        <input type="text" name="ADDRESS" value="<?php echo $applicant['ADDRESS']; ?>" required><br>
        <label>Contact Number:</label>
        <input type="text" name="CONTACTNO" value="<?php echo $applicant['CONTACTNO']; ?>" required><br>
        <label>Email Address:</label>
        <input type="email" name="EMAILADDRESS" value="<?php echo $applicant['EMAILADDRESS']; ?>" required><br>
        <button type="submit">Update</button>
    </form>
</body>
</html>
