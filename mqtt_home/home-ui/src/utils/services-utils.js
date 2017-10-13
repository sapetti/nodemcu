

export const fetchBoards = () => {
  console.log('fetching all boards')
  return new Promise((resolve, reject) => {
    fetch('http://localhost:3030/boards')
    .then( response => response.json())
    .then( boards => resolve(boards))
    .catch( err => {
      console.error(err)
      reject(err)
    })
  })
}

  export const runService = (key, service) => {
    console.log('running service', key, service)
    fetch('http://localhost:3030/boards' + key + '/' + service)
    .then( response => response.json())
    .then( response => console.log('runService', response))
    .catch( err => console.error(err) )
  }
