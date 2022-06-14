package utils;

public interface IDatabaseQuery<T> {
    public T[] query(DatabaseConnection databaseConnection);
}

