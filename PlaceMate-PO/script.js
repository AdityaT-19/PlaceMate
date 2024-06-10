document.addEventListener("DOMContentLoaded", function () {
  // Initialize Materialize components
  const elems = document.querySelectorAll(".sidenav");
  M.Sidenav.init(elems);
  const modalElems = document.querySelectorAll(".modal");
  M.Modal.init(modalElems);

  const selectElems = document.querySelectorAll("select");
  M.FormSelect.init(selectElems);

  // Your web app's Firebase configuration
  const firebaseConfig = {
    apiKey: "AIzaSyDkdfN-EcDQH2kJP7Qp6uk4skftVHXH2mM",
    appId: "1:37632358817:web:4ab1d96bf93ce258cd73e0",
    messagingSenderId: "37632358817",
    projectId: "placemate-6cc73",
    authDomain: "placemate-6cc73.firebaseapp.com",
    storageBucket: "placemate-6cc73.appspot.com",
  };

  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);

  // Initialize Firestore
  const db = firebase.firestore();

  // Function to render company details
  const renderCompanies = () => {
    const companyDetails = document.getElementById("company-details");
    companyDetails.innerHTML = ""; // Clear previous content
    db.collection("company")
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const company = doc.data();
          companyDetails.innerHTML += `
            <div class="company">
              <h5>${company.name}</h5>
              <p>CGPA Cutoff: ${company.cgpa}</p>
              <p>CTC: ${company.ctc} LPA</p>
              <p>Job Role: ${company.jobRole}</p>
              <p>Job Description: ${company.jobDescription}</p>
              <p>Location: ${company.location}</p>
              <p>Internship Duration: ${company.duration} months</p>
            </div>
          `;
        });
      })
      .catch((error) => {
        console.error("Error fetching companies: ", error);
      });
  };

  // Function to render student details
  const renderStudents = () => {
    const studentDetails = document.getElementById("student-details");
    studentDetails.innerHTML = ""; // Clear previous content
    db.collection("student")
      .get()
      .then((querySnapshot) => {
        querySnapshot.forEach((doc) => {
          const student = doc.data();
          studentDetails.innerHTML += `
            <div class="student">
              <h5>${student.name}</h5>
              <p>USN: ${student.usn}</p>
              <p>Semester: ${student.sem}</p>
              <p>Section: ${student.section}</p>
              <p>CGPA: ${student.cgpa}</p>
              <p>Backlogs: ${student.backlogs}</p>
              <p>Department: ${student.dept}</p>
              <p>Resume Link: <a href="${student.resume}" target="_blank">View Resume</a></p>
            </div>
          `;
        });
      })
      .catch((error) => {
        console.error("Error fetching students: ", error);
      });
  };

  // Event listeners for viewing sections
  document
    .getElementById("view-companies")
    .addEventListener("click", function () {
      renderCompanies();
      document.getElementById("company-details").classList.toggle("hidden");
    });

  document
    .getElementById("view-students")
    .addEventListener("click", function () {
      renderStudents();
      document.getElementById("student-details").classList.toggle("hidden");
    });

  // Add company modal submission handler
  document
    .getElementById("company-form")
    .addEventListener("submit", function (e) {
      e.preventDefault();

      const companyDetails = {
        name: document.getElementById("company-name").value,
        cgpa: Number(document.getElementById("company-cgpa").value),
        ctc: Number(document.getElementById("company-ctc").value),
        jobRole: document.getElementById("jobrole").value,
        jobDescription: document.getElementById("jobdescription").value,
        location: document.getElementById("company-location").value,
        duration: Number(document.getElementById("company-internship").value),
      };

      db.collection("company")
        .add(companyDetails)
        .then(() => {
          console.log("Company added successfully!");
          M.Modal.getInstance(
            document.getElementById("add-company-modal")
          ).close();
          document.getElementById("company-form").reset();
          M.toast({ html: "Company added successfully!" });
        })
        .catch((error) => {
          console.error("Error adding company: ", error);
        });
    });

  // Add student modal submission handler
  document
    .getElementById("student-form")
    .addEventListener("submit", function (e) {
      e.preventDefault();

      const studentDetails = {
        usn: document.getElementById("student-usn").value,
        name: document.getElementById("student-name").value,
        sem: Number(document.getElementById("student-sem").value),
        section: document.getElementById("student-section").value,
        cgpa: Number(document.getElementById("student-cgpa").value),
        backlogs: Number(document.getElementById("student-backlogs").value),
        dept: document.getElementById("student-department").value,
        resume: document.getElementById("student-resume").value,
        email: document.getElementById("student-email").value,
      };
      const auth = firebase.auth();
      auth
        .createUserWithEmailAndPassword(studentDetails.email, "12345678")
        .then((userCredential) => {
          const id = userCredential.user.uid;

          db.collection("student")
            .doc(id)
            .set(studentDetails)
            .then(() => {
              console.log("Student added successfully!");
              M.Modal.getInstance(
                document.getElementById("add-student-modal")
              ).close();
              document.getElementById("student-form").reset();
              M.toast({ html: "Student added successfully!" });
            })
            .catch((error) => {
              console.error("Error adding student: ", error);
            });
        });
    });
  const renderShortlistedStudents = () => {
    const shortlistedDetails = document.getElementById("shortlisted-students");
    shortlistedDetails.innerHTML = ""; // Clear previous content

    db.collection("applications")
      .get()
      .then(async (querySnapshot) => {
        for (const doc of querySnapshot.docs) {
          const application = doc.data();
          // Fetch company name
          const companySnapshot = await db
            .collection("company")
            .doc(application.companyId)
            .get();
          const companyName = companySnapshot.exists
            ? companySnapshot.data().name
            : "Unknown";

          const shortlistedElement = document.createElement("div");
          shortlistedElement.classList.add("shortlisted");
          shortlistedElement.innerHTML = `
                <h5>${application.studentUsn}</h5>
                <p>Company: ${companyName}</p>
                <p>Date of Application: ${application.date}</p>
                <p>Status: 
                  <select class="status-edit" data-application-id="${doc.id}">
                    <option value="applied" ${
                      application.status === "applied" ? "selected" : ""
                    }>Applied</option>
                    <option value="shortlisted" ${
                      application.status === "shortlisted" ? "selected" : ""
                    }>Shortlisted</option>
                    <option value="placed" ${
                      application.status === "placed" ? "selected" : ""
                    }>Placed</option>
                  </select>
                </p>
              `;
          shortlistedDetails.appendChild(shortlistedElement);
        }

        // Initialize form select components after rendering shortlisted applications
        const selectElems = document.querySelectorAll(".status-edit");
        M.FormSelect.init(selectElems);

        // Add event listeners for status change
        document.querySelectorAll(".status-edit").forEach((select) => {
          select.addEventListener("change", function () {
            const selectedOption = this.value;
            const applicationId = this.dataset.applicationId;
            db.collection("applications")
              .doc(applicationId)
              .update({ status: selectedOption })
              .then(() => {
                M.toast({ html: `Status updated to ${selectedOption}` });
              })
              .catch((error) => {
                console.error("Error updating status: ", error);
              });
          });
        });
      })
      .catch((error) => {
        console.error("Error fetching applications: ", error);
      });
  };

  // Event listener for viewing shortlisted students
  document
    .getElementById("view-shortlisted")
    .addEventListener("click", function () {
      renderShortlistedStudents();
      document
        .getElementById("shortlisted-students")
        .classList.toggle("hidden");
    });
});
