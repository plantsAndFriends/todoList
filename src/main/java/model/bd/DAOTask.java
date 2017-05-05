/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model.bd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
//import java.sql.Date;
import java.util.Locale;
import model.pojo.BeanTask;
import model.pojo.BeanUser;

/**
 *
 * @author clara
 */
public class DAOTask extends Bd {

    private Connection conn;
    private Statement stmt;

    public DAOTask() throws Exception {

        conn = getConnexio();
        stmt = conn.createStatement();
    }

    public void insertTask(String task, int userId) throws Exception {
        stmt.executeUpdate("INSERT INTO task (task, user_id) VALUES ('" + task + "','" + userId + "')");
    }

    public ArrayList<BeanTask> getTasks(int userId) throws Exception {
        ResultSet rs = stmt.executeQuery("SELECT * FROM task WHERE user_id = " + userId + " ORDER BY id ");

        ArrayList<BeanTask> listTask = new ArrayList();

        while (rs.next()) {
            BeanTask task = new BeanTask();

            int id = rs.getInt("id");
            String t = rs.getString("task");
            Date st = rs.getDate("startedAt");
            Date ct = rs.getDate("completedAt");
            int uId = rs.getInt("user_id");

            task.setId(id);
            task.setTask(t);
            task.setStartedAt(st);
            task.setCompletedAt(ct);
            task.setUser_id(uId);
            listTask.add(task);
        }
        return listTask;

    }

    public void removeTask(int id) throws SQLException {
        stmt.executeUpdate("DELETE FROM task WHERE id = " + id);
    }

    public void startTask(int id) throws SQLException {
        stmt.executeUpdate("UPDATE task SET startedAt = NOW() WHERE id = " + id);
    }

    public void pauseTask(int id) throws SQLException {
        stmt.executeUpdate("UPDATE task SET completedAt = NOW() WHERE id = " + id);
    }

    public Date getStartedAt(int id) throws SQLException {
        /*ResultSet rs = stmt.executeQuery("SELECT startedAt FROM task WHERE id = " + id);
        return rs.getDate("startedAt");*/
        
        Date start = null;
        String sql = "SELECT startedAt FROM task WHERE id = " + id;
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            start =  rs.getDate("startedAt");
        }
        
        return start;
    }

    public Date getCompletedAt(int id) throws SQLException {
        /*ResultSet rs = stmt.executeQuery("SELECT completedAt FROM task WHERE id = " + id);
        return rs.getDate("completedAt");*/
        
        Date pause = null;
        String sql = "SELECT completedAt FROM task WHERE id = " + id;
        
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            pause =  rs.getDate("completedAt");
        }
        
        return pause;
    }

    public long totalTime(Date st, Date ct) { // retornarà algo        
        String start = st.toString();
        String completed = ct.toString();
        
        long diffSeconds = 0;
        
        SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.ENGLISH);
        
        /*long diffMinutes = 0;
        SimpleDateFormat format = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
        Date d1 = null;
        Date d2 = null;
        try {
            d1 = format.parse(start);
            d2 = format.parse(completed);
            
            long diff = d2.getTime() - d1.getTime();
            
            diffMinutes = diff / (60 * 1000) % 60;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        */
        
        Date d1 = null;
        Date d2 = null;
        
        try {
            d1 = format.parse(start); // Es queda aquí
            System.out.println("d1: " + d1);
            d2 = format.parse(completed);
            
            
            // in milliseconds
            long diff = d2.getTime() - d1.getTime();
            System.out.println("diff: " + diff);
            
            diffSeconds = diff / 1000 % 60;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return diffSeconds;
    }

}
