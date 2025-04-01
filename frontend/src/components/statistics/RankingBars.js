import { Bar } from 'react-chartjs-2'
import { useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import Chart from 'chart.js/auto';

const RankingBars = ({ userNames, winCounts }) => {
    const chartRef = useRef();
    const navigate = useNavigate();

    const onClick = (event, clickedElements) => {
        if (clickedElements.length === 0) return
      
        const { dataIndex, raw } = clickedElements[0].element.$context
        const barLabel = event.chart.data.labels[dataIndex]
        navigate("/user/" + barLabel+"/1");
      }

    return (
        <div style={{ height: '100%', width: '100%', minWidth: '800px', minHeight: '400px' }} >
            <Bar 
                ref={chartRef}
                data={{
                    labels: userNames,
                    datasets: [
                        {
                            data: winCounts,
                            backgroundColor: ["red", "blue", "green", "yellow", "orange", "purple", "pink", "brown", "gray", "black", "white"],
                        },
                    ],
                }}
                options={{
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false,
                        },
                    },
                    scales: {
                        y: {
                            ticks: {
                                stepSize: 1
                            },
                        }
                    },
                    onClick,

                    
                }}
            />
        </div>);
}

export default RankingBars;
