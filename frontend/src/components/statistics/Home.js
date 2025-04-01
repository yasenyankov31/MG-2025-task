
import useSWR from 'swr'
import { useState, useEffect } from 'react'
import { Container, Button, Tab, Tabs, Navbar } from 'react-bootstrap';
import Loading from '../general/Loading';
import ErrorComponent   from '../general/Error';
import RankingBars from './RankingBars';
import { useNavigate } from 'react-router-dom';
import TranslateI18n from '../general/TranslateI18n';




const Home = () => {
    const [loading, setLoading] = useState(false)
    const navigate = useNavigate();

    const { data, error, isLoading } = useSWR('/api/games')
    useEffect(() => {
        setLoading(isLoading);
    }, [isLoading]);

    const createGame = () => {
        fetch('/api/games', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        })
            .then(response => response.json())
            .then(game => {
                setLoading(true)
                navigate('/game/' + game.id);
            })
            .catch((error) => {
                console.log(error)
            });


    };

    if (error) return <ErrorComponent message={"An error occured fetching the games ranking data." + error.message} />
    if (loading) return <Loading />

    return (<div >
        <Navbar></Navbar>
        <Container className="d-flex align-items-center justify-content-center vh-100">
            {data && <div className="text-center ">
                <div className='d-none d-sm-block'>
                    <Tabs defaultActiveKey="first" className="mb-3 ">
                        <Tab eventKey="first" title={<TranslateI18n id = {"Top10AllTime"}/>} >                         
                            <RankingBars userNames={data.month.userNames} winCounts={data.month.winCounts} />
                        </Tab>
                        <Tab eventKey="second" title={<TranslateI18n id = {"Top10Monthly"}/>}>
                            <RankingBars userNames={data.allTime.userNames} winCounts={data.allTime.winCounts} />
                        </Tab>
                    </Tabs>
                </div>
                <Button variant="primary" className="mt-3" onClick={createGame}>
                    <TranslateI18n id={"StartGameBtn"}/>
                </Button>
            </div>}
        </Container>


    </div>);
}

export default Home;