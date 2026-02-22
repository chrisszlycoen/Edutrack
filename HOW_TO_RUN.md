# How to Run Edutrack

This project is a Java Web Application (WAR) based on Jakarta EE 10. To run it locally, you need **Tomcat 10.1** or higher.

## Option 1: Quick Run with Maven (Recommended)
This method is the simplest for local development as it uses an embedded Tomcat server.

1. Open your terminal in the project root directory.
2. Run the following command:
   ```bash
   ./mvnw clean package cargo:run
   ```
3. Once the server starts, access the app at:
   `http://localhost:8080/Edutrack`

---

## Option 2: Manual Deployment (Standalone Tomcat)
Use this if you have a pre-installed Tomcat server on your PC.

1. **Build the project**:
   ```bash
   ./mvnw clean package
   ```
2. **Locate the WAR file**:
   The file will be at `target/Edutrack-1.0-SNAPSHOT.war`.
3. **Deploy to Tomcat**:
   - Copy the `.war` file to your Tomcat's `webapps/` directory.
   - *Tip*: Rename it to `ROOT.war` if you want it to be accessible at `http://localhost:8080/` without the `/Edutrack` context.
4. **Start Tomcat**:
   - Run `bin/startup.sh` (Linux/macOS) or `bin/startup.bat` (Windows).
5. **Access the app**:
   `http://localhost:8080/Edutrack-1.0-SNAPSHOT`

---

## Prerequisites
- **JDK 21**: Required for this project (configured in `pom.xml`).
- **MySQL**: Ensure your database is running and configured in `src/main/resources/hibernate.cfg.xml`.

---

## Default Credentials
- **Username**: `admin`
- **Password**: `admin123`
*(You will be prompted to change the password on first login)*

