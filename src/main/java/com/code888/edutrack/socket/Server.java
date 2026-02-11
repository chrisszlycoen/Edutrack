package com.code888.edutrack.socket;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
    public static void main(String[] args) {
        try(ServerSocket serverSocket = new ServerSocket(8888);) {
            System.out.println("Server started on port 8888...");

            Socket socket = serverSocket.accept();
            System.out.println("Client connected on port 8888...");
            BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            PrintWriter out = new PrintWriter(socket.getOutputStream(), true);
            String message = in.readLine();
            System.out.println("Server received message: " + message);
            out.println("Hello from server");
            socket.close();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
