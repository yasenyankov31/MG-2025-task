import { Container, Table, Button } from 'react-bootstrap';
import Loading from '../general/Loading';
import ErrorComponent from '../general/Error';
import useSWR from 'swr'
import { useState, useEffect, useCallback } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import PaginationComponent from '../general/Pagination';
import TranslateI18n from '../general/TranslateI18n';



const Games = () => {
  const navigate = useNavigate();
  const { page: initialPage } = useParams();
  const [pageNumber, setPageNumber] = useState(initialPage);
  const [games, setGames] = useState(null); // Initialize state to hold fetched data

  const { data, error } = useSWR(`/api/games/not-completed-games?pageNum=${pageNumber}`,
    {
      revalidateOnFocus: false,
      revalidateOnReconnect: false,
      dedupingInterval: 1000,
    });

  const handlePagination = useCallback((newPageNumber) => {
    setPageNumber(newPageNumber);
  }, []);

  const viewGame = (gameId) => {
    navigate('/game/' + gameId)
  };

  useEffect(() => {
    setPageNumber(Number(initialPage));
  }, [initialPage]);

  // Update state when data changes
  useEffect(() => {
    if (data) {
      setGames(data);
    }
  }, [data]);

  if (error) return <ErrorComponent message={"An error occured fetching the games ranking data." + error.message} />

  if (!games) return <Loading />

  return (
    <Container className="d-flex flex-column align-items-center justify-content-center ">
      {games &&
        <div className="d-flex flex-column align-items-center justify-content-center p-5">
          <h1 className="p-5"><TranslateI18n id={"GamesTableTitle"} /></h1>
          <Table className='table-dark' striped bordered >
            <thead>
              <tr>
                <th><TranslateI18n id={"GamesTableAttemptsColumn"} /></th>
                <th><TranslateI18n id={"GamesTableDateColumn"} /></th>
                <th><TranslateI18n id={"GamesTableWordColumn"} /></th>
                <th></th>
              </tr>
            </thead>
            <tbody>
              {games.content.map((game, index) => {
                const date = new Date(game.date);
                return (
                  <tr key={index}>
                    <td>{game.attemptsLeft}</td>
                    <td>{date.toLocaleDateString()}</td>
                    <td>{game.guessedWord}</td>
                    <td>
                      <Button onClick={() => { viewGame(game.id) }}><TranslateI18n id={"GamesTableContinueBtn"} /></Button>
                    </td>
                  </tr>);
              })}
            </tbody>
          </Table>
          <PaginationComponent
            totalPages={games.totalPages}
            pageNumber={pageNumber}
            totalElements={games.totalElements}
            handlePagination={handlePagination} />
        </div>
      }


    </Container>

  );
};


export default Games;
