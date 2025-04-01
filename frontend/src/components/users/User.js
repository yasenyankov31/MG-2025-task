import { useState, useEffect } from 'react';
import useSWR from 'swr'
import { useParams } from 'react-router-dom'
import { Container, Row, Col, Table } from 'react-bootstrap';
import { Line, Pie } from 'react-chartjs-2'
import Loading from '../general/Loading';
import ErrorComponent from '../general/Error';
import PaginationComponent from '../general/Pagination';
import Chart from 'chart.js/auto';
import TranslateI18n from '../general/TranslateI18n';
import { useTranslation } from 'react-i18next';



const User = () => {
    const { username, page } = useParams();
    const { t } = useTranslation();

    const gameStat = [t('WinsChart'), t('LossesChart')];
    const barColors = [
        "#1e7145",
        "#b91d47"
    ];
    


    const userPorfileResponse = useSWR('/api/users/user-profile?username=' + username)
    const userGamesResponse = useSWR('/api/users/played-games?username=' + username + "&pageNum=" + page)
    const [games, setGames] = useState([]);
    const [pageNumber, setPageNumber] = useState(page);
    const [totalPages, setTotalPages] = useState(0);
    const [totalElements, setTotalElements] = useState(0);

    function generateAscendingArray(highestNumber) {
        var result = [];
        for (var i = 1; i <= highestNumber; i++) {
            result.push(i);
        }
        return result;
    }

    const handlePagination = (pageNumber) => {
        fetch("/api/users/played-games?username=" + username + "&pageNum=" + pageNumber, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            }
        })
            .then(response => response.json())
            .then(games => {
                setTotalElements(games.totalElements);
                setGames(games.content);
                setTotalPages(games.totalPages);
            });
        setPageNumber(pageNumber);
    }

    useEffect(() => {
        if (userGamesResponse.data) {
            setTotalElements(userGamesResponse.data.totalElements);
            setGames(userGamesResponse.data.content);
            setTotalPages(userGamesResponse.data.totalPages);
            setPageNumber(Number(page));
        }

    }, [userGamesResponse.data]);



    if (userPorfileResponse.error) return <ErrorComponent message={"An error occured fetching the games ranking data." + userPorfileResponse.error.message} />
    if (userGamesResponse.error) {
        return <ErrorComponent message={"An error occured fetching the games ranking data." + userGamesResponse.error.message} />
    }

    if (userPorfileResponse.isLoading || userGamesResponse.isLoading) return <Loading />




    return (
        <div>
            <Container className='p-5'>
             <h1 className='p-5'><TranslateI18n id="UserProfileTitle"/>{username}</h1>
                <Row>
                    <Col className="d-flex justify-content-center align-items-center">
                        <Line
                            data={{
                                labels: generateAscendingArray(userPorfileResponse.data.statusValues.length),
                                datasets: [
                                    {
                                        label: t('WinStreaksChart'),
                                        data: userPorfileResponse.data.statusValues,
                                        lineTension: 0.5
                                    },
                                ],
                            }}
                            options={{
                                maintainAspectRatio: true,
                                plugins: {
                                    legend: {
                                        display: true,
                                    },
                                },
                                scales: {
                                    y: {
                                        ticks: {
                                            stepSize: 1
                                        },
                                    }
                                }
                            }}
                        />
                    </Col>
                    <Col >
                        <Pie
                            data={{
                                labels: gameStat,
                                datasets: [
                                    {
                                        data: [userPorfileResponse.data.winCount, userPorfileResponse.data.lossCount],
                                        backgroundColor: barColors
                                    },
                                ],
                            }}
                            options={{
                                maintainAspectRatio: false,
                            }}
                            height={250}
                            width={350}
                        />
                    </Col>
                </Row>
                <Container  >
                    <h1 className='p-3'><TranslateI18n id="UserProfileTableTitle"/></h1>
                    <Table className='table-dark' striped bordered>
                        <thead>
                            <tr>
                                <th><TranslateI18n id="UserProfileColumnWord"/></th>
                                <th><TranslateI18n id="UserProfileColumnAttemptsLeft"/></th>
                                <th><TranslateI18n id="UserProfileColumnGameStatus"/></th>
                                <th><TranslateI18n id="UserProfileColumnCreationDate"/></th>
                                <th><TranslateI18n id="UserProfileColumnUsedLetters"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            {games.map((game, index) => {
                                const date = new Date(game.startDate);
                                return (
                                    <tr key={index}>
                                        <td>{game.word}</td>
                                        <td>{game.attemptsLeft}</td>
                                        <td>{game.gameStatus}</td>
                                        <td>{date.toLocaleDateString()}</td>
                                        <td>{game.lettersUsed}</td>
                                    </tr>
                                );
                            })}
                        </tbody>
                    </Table>

                    <PaginationComponent
                            style={{ alignSelf: 'flex-end' }} 
                            totalPages={totalPages}
                            totalElements={totalElements}
                            pageNumber={pageNumber}
                            handlePagination={handlePagination} />

                </Container>
            </Container>


        </div>
    );
}

export default User;