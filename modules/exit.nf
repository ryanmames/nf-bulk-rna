process EXIT {

    errorStrategy {error.exists() ? 'terminate':'ignore'}
    
    input:
    path (error)

    exec:
    exit 1, "ERROR: Validation has failed please see errors.txt"
}