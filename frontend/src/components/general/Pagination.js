import React from 'react';
import { Container, Pagination } from 'react-bootstrap';
import TranslateI18n from './TranslateI18n';

const PaginationComponent = ({ totalPages, totalElements, pageNumber, handlePagination }) => {
  return (
    <Container style={{paddingTop:'40px'}}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div><h6><TranslateI18n id={"PaginationTotalElements"}/> {totalElements}</h6></div>
        <Pagination>
          <Pagination.First onClick={() => handlePagination(1)} disabled={pageNumber === 1} />
          <Pagination.Prev onClick={() => handlePagination(pageNumber - 1)} disabled={pageNumber === 1} />

          {[...Array(totalPages)].map((_, i) => {
            if (i + 1 === pageNumber || i + 1 === pageNumber - 1 || i + 1 === pageNumber + 1 || i + 1 === pageNumber - 2 || i + 1 === pageNumber + 2) {
              return (
                <Pagination.Item key={i} active={i + 1 === pageNumber} onClick={() => handlePagination(i + 1)}>
                  {i + 1}
                </Pagination.Item>
              );
            }
            if ((i === 0 && pageNumber > 3) || (i + 1 === totalPages && pageNumber < totalPages - 2)) {
              return <Pagination.Ellipsis key={i} />;
            }
            return null;
          })}

          <Pagination.Next onClick={() => handlePagination(pageNumber + 1)} disabled={pageNumber === totalPages} />
          <Pagination.Last onClick={() => handlePagination(totalPages)} disabled={pageNumber === totalPages} />
        </Pagination>
      </div>
    </Container>
  );
};

export default PaginationComponent;
