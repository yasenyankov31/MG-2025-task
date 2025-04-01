import { Container, Button, Table, Form } from 'react-bootstrap';
import Loading from '../general/Loading';
import ErrorComponent from '../general/Error';
import useSWR from 'swr'
import { useState, useEffect,useCallback} from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import PaginationComponent from '../general/Pagination';
import UserModal from './UserModal';
import TranslateI18n from '../general/TranslateI18n';




const Users = () => {
    const navigate = useNavigate();
    const { page: initialPage } = useParams();
    const [pageNumber, setPageNumber] = useState(initialPage);

    const {
        data:users,
        error,
        mutate: mutateUsers,
    } = useSWR(`/api/users?pageNum=${pageNumber}`, {
        revalidateOnFocus: false,
        revalidateOnReconnect: false,
        dedupingInterval: 10000,
    });

    const [showUserModal, setShowUserModal] = useState(false);
    const [selectedUser, setSelectedUser] = useState(null);
    const [selectedUserIds, setSelectedUserIds] = useState(new Set());
    const [selectedUserIdsModal, setSelectedUserIdsModal] = useState(new Set());

    const [allCheck, setAllCheck] = useState(false);
    const [isDeleting, setIsDeleting] = useState(false);

    const [localUsers, setLocalUsers] = useState(users);

    useEffect(() => {
        if (users) {
            setLocalUsers(users);
          }
      
    }, [users]);

    useEffect(() => {
        setPageNumber(Number(initialPage));
      }, [initialPage]);


    function toggleUserSelection(userId, isChecked) {
        setSelectedUserIds((prevSelectedUserIds) => {
            const newSelectedUserIds = new Set(prevSelectedUserIds);
            if (isChecked) {
                newSelectedUserIds.add(userId);
            } else {
                newSelectedUserIds.delete(userId);
            }
            return newSelectedUserIds;
        });
    }

    function toggleSelectAll(isChecked) {
        setAllCheck(!allCheck);
        setSelectedUserIds((prevSelectedUserIds) => {
            if (isChecked) {
                return new Set(users.content.map(user => user.id));
            } else {
                return new Set();
            }
        });
    }

    const handlePagination = useCallback((newPageNumber) => {
        setPageNumber(newPageNumber);
    }, []);

    const closeModal = () => {
        mutateUsers();
        setSelectedUser(null);
        setSelectedUserIdsModal(new Set());
        setShowUserModal(false);
    };

    const updateUserData = () => {
        mutateUsers();
    };

    const showModal = () => {  
        setShowUserModal(true);
    }

    const viewUserProfile = (username) => {
        navigate("/user/" + username + "/1");
    }

    const editUser = (user) => {
        setSelectedUser(user);
        setShowUserModal(true);
        
    }

    const deleteUser = (ids) => {
        setSelectedUserIdsModal(ids);
        setIsDeleting(true);
        setShowUserModal(true);

    }





    


    if (error) return <ErrorComponent message={"An error occured fetching the users data."
        + error.message} />
    if (!localUsers) return <Loading />



    return (
        <Container className="d-flex flex-column align-items-center justify-content-center ">
            <UserModal
                show={showUserModal}
                closeModal={closeModal}
                userData={selectedUser}
                updateUsers={updateUserData}
                deleteIds={selectedUserIdsModal}
                isDeleting={isDeleting}
            />
            <div className="p-5">
                <h1 className="p-5 d-flex flex-column align-items-center justify-content-center"><TranslateI18n id={"UsersTableTitle"} /></h1>
                <div className=" justify-content-start">
                    <Button id="AddBtn" className='m-1 btn-primary' onClick={() => { showModal() }}><TranslateI18n id={"UsersAddBtn"} /></Button>
                    <Button className='m-1 btn-danger' onClick={() => { deleteUser(selectedUserIds) }}><TranslateI18n id={"UsersDeleteBtn"} /></Button>
                </div>
                <Table className='table-dark' striped bordered >
                    <thead>
                        <tr>
                            <th className='text-center'><TranslateI18n id={"UsersTableSelectAllColumn"} />
                                <Form.Check
                                    type="checkbox"
                                    id="select-all"
                                    checked={allCheck}
                                    onChange={e => toggleSelectAll(e.target.checked)}
                                />
                            </th>
                            <th><TranslateI18n id={"UsersTableUsernameColumn"} /></th>
                            <th><TranslateI18n id={"UsersTablePasswordColumn"} /></th>
                            <th><TranslateI18n id={"UsersTableAgeColumn"} /></th>
                            <th><TranslateI18n id={"UsersTableBirthDateColumn"} /></th>
                            <th><TranslateI18n id={"UsersTableActionsColumn"} /></th>
                            <th><TranslateI18n id={"UsersTableViewProfileColumn"} /></th>
                        </tr>
                    </thead>
                    <tbody>
                        {localUsers.content.map((user, index) => {
                            const date = new Date(user.birthDate);
                            return (
                                <tr id={"table-record-"+index} key={index}>
                                    <td className="text-center">
                                        <Form.Check
                                            type="checkbox"
                                            id={`select-${index}`}
                                            onChange={e => toggleUserSelection(user.id, e.target.checked)}
                                            checked={selectedUserIds.has(user.id)}
                                        />
                                    </td>
                                    <td id="username">{user.username}</td>
                                    <td id="password">{user.password}</td>
                                    <td id="age">{user.age}</td>
                                    <td id="birthDate">{date.toLocaleDateString()}</td>
                                    <td className="text-center">
                                        <a className="text-warning p-2" onClick={() => { editUser(user) }} >
                                            <i className="material-icons" title="Edit">&#xE254;</i>
                                        </a>
                                        <a className="text-danger" onClick={() => {
                                            const singleIdSet = new Set([Number(user.id)]);
                                            deleteUser(singleIdSet);
                                        }}>
                                            <i className="material-icons" title="Delete">&#xE872;</i>
                                        </a>
                                    </td>
                                    <td className="text-center">
                                        <a className="view" onClick={() => { viewUserProfile(user.username) }}>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" className="bi bi-person-fill" viewBox="0 0 16 16">
                                                <path d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3Zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Z" />
                                            </svg>
                                        </a>
                                    </td>
                                </tr>
                            );
                        })}
                    </tbody>
                </Table>

                <PaginationComponent
                    totalPages={localUsers.totalPages}
                    pageNumber={pageNumber}
                    totalElements={localUsers.totalElements}
                    handlePagination={handlePagination} />
            </div>
        </Container >

    );
};


export default Users;
