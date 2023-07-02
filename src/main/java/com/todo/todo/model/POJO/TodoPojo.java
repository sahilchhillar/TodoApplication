package com.todo.todo.model.POJO;

import java.time.LocalDate;

public class TodoPojo {
    private String ID;
    private String task;
    private boolean pending;
    private LocalDate createdOn;
    private LocalDate completedOn;

    /**
     * @return String return the ID
     */
    public String getID() {
        return ID;
    }

    /**
     * @param ID the ID to set
     */
    public void setID(String ID) {
        this.ID = ID;
    }

    /**
     * @return String return the task
     */
    public String getTask() {
        return task;
    }

    /**
     * @param task the task to set
     */
    public void setTask(String task) {
        this.task = task;
    }

    /**
     * @return LocalDate return the createdOn
     */
    public LocalDate getCreatedOn() {
        return createdOn;
    }

    /**
     * @param createdOn the createdOn to set
     */
    public void setCreatedOn(LocalDate createdOn) {
        this.createdOn = createdOn;
    }


    /**
     * @return boolean return the pending
     */
    public boolean isPending() {
        return pending;
    }

    /**
     * @param pending the pending to set
     */
    public void setPending(boolean pending) {
        this.pending = pending;
    }

    /**
     * @return LocalDate return the completedOn
     */
    public LocalDate getCompletedOn() {
        return completedOn;
    }

    /**
     * @param completedOn the completedOn to set
     */
    public void setCompletedOn(LocalDate completedOn) {
        this.completedOn = completedOn;
    }

}
