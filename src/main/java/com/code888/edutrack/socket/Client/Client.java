package com.code888.edutrack.socket.Client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class Client {
    public static void main(String[] args) {
        try(Socket socket = new Socket("localhost", 8888)){
            BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));

            PrintWriter output = new PrintWriter(socket.getOutputStream(), true);
            output.println("Hello server!");
            String response= input.readLine();
            System.out.println("Server says: " + response); 
        } catch(IOException e){
            e.printStackTrace();
        }
    }
}

